class ProductManagerCopilotController < ApplicationController
    before_action :authenticate_user!
    before_action :set_product_idea
    before_action :set_prd
    before_action :set_conversation, only: [:show, :update]
  
    def show
      @messages = @conversation.messages.order(created_at: :asc)
    end
  
    def create
      @conversation = @prd.conversations.create!
      redirect_to product_idea_prd_product_manager_copilot_path(@product_idea, @prd, @conversation)
    end
  
    def update
      message = @conversation.messages.create!(content: params[:message], role: 'user')
      
      ai_response = generate_ai_response(@conversation, message.content)
      
      @conversation.messages.create!(content: ai_response, role: 'assistant')
  
      render json: { 
        response: ai_response
      }
    end
  
    private
  
    def set_product_idea
      @product_idea = ProductIdea.find(params[:product_idea_id])
    end
  
    def set_prd
      @prd = @product_idea.prds.find(params[:prd_id])
    end
  
    def set_conversation
      @conversation = @prd.conversations.find(params[:id])
    end
  
    def generate_ai_response(conversation, user_message)
      messages = conversation.messages.order(created_at: :asc).map do |msg|
        { role: msg.role, content: msg.content }
      end
  
      client = OpenAI::Client.new
      
      system_message = "You are a helpful Product Manager Copilot. Assist the user in improving their PRD."
      
      case user_message
      when "Improve PRD structure"
        system_message += " The user wants to improve the PRD structure. Provide a detailed list of suggestions to enhance the organization and flow of the PRD."
      when "Clarify requirements"
        system_message += " The user wants to clarify requirements. Ask specific questions about different sections of the PRD and provide suggestions for making requirements more precise and actionable."
      when "Suggest features"
        system_message += " The user is looking for feature suggestions. Based on the context of their PRD, provide a list of innovative and relevant feature ideas that could enhance the product."
      when "Review PRD"
        system_message += " The user wants a review of their PRD. Provide a comprehensive analysis, including strengths, areas for improvement, and specific recommendations for each major section of the PRD."
      end
  
      response = client.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          messages: [
            { role: "system", content: system_message },
            *messages,
            { role: "user", content: user_message }
          ],
          temperature: 0.7,
          max_tokens: 500  # Increased for more detailed responses
        }
      )
  
      response.dig("choices", 0, "message", "content") || "I'm here to help with your PRD. What specific aspect would you like assistance with?"
    end
  end