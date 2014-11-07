module ControllerNameHelper
 def current_controller_name(controller)
   #params[:controller].capitalize
   controller.controller_name.humanize
 end
end
