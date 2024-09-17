module ApplicationHelper
    def status_color(status)
      case status
      when 'New'
        'bg-blue-100 text-blue-800'
      when 'In Progress'
        'bg-yellow-100 text-yellow-800'
      when 'Completed'
        'bg-green-100 text-green-800'
      else
        'bg-gray-100 text-gray-800'
      end
    end
  end
