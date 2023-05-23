module RegistrationsHelper
  def errors(resource)
    render partial: 'devise/shared/error_messages', locals: { resource: resource } if resource.errors.any?
  end
end
