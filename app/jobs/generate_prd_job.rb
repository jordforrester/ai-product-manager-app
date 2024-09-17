class GeneratePrdJob < ApplicationJob
    queue_as :default
  
    def perform(prd_id)
      prd = Prd.includes(:product_idea).find(prd_id)
      begin
        generated_content = generate_prd_content(prd.product_idea)
        prd.update!(content: generated_content, status: 'completed')
      rescue => e
        Rails.logger.error "PRD generation failed for PRD #{prd_id}: #{e.message}"
        Rails.logger.error e.backtrace.join("\n")
        prd.update!(status: 'failed', content: "Generation failed: #{e.message}")
      end
    end
  
    private
  
    def generate_prd_content(product_idea)
      client = OpenAI::Client.new
  
      prompt = <<~PROMPT
        Generate a Product Requirements Document (PRD) for the following product idea:
  
        Title: #{product_idea.title}
        Description: #{product_idea.description}
  
        The PRD should include the following sections:
        1. Executive Summary
        2. Problem Statement
        3. Product Overview
        4. Features and Functionality
        5. User Stories
        6. Technical Requirements
        7. Timeline and Milestones
        8. Risks and Mitigation Strategies
        9. Go to Market 
  
        Please provide detailed and specific information for each section based on the given product idea.
      PROMPT
  
      response = client.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          messages: [{ role: "user", content: prompt }],
          temperature: 0.7,
          max_tokens: 2000
        }
      )
  
      response.dig("choices", 0, "message", "content")
    end
  end