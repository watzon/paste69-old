# This class handles error responses and reporting.
#
# https://luckyframework.org/guides/http-and-routing/error-handling
class Errors::Show < Lucky::ErrorAction
  DEFAULT_MESSAGE = "Something went wrong."
  default_format :html
  dont_report [Lucky::RouteNotFoundError, Avram::RecordNotFoundError]

  def render(error : Lucky::RouteNotFoundError | Avram::RecordNotFoundError)
    Raven.capture(error)
    if html?
      error_html "Sorry, we couldn't find that page.", status: 404
    else
      error_json false, "Not found", status: 404
    end
  end

  # When the request is JSON and an InvalidOperationError is raised, show a
  # helpful error with the param that is invalid, and what was wrong with it.
  def render(error : Avram::InvalidOperationError)
    Raven.capture(error)
    if html?
      error_html DEFAULT_MESSAGE, status: 500
    else
      error_json \
        success: false,
        error: error.renderable_message,
        details: error.renderable_details,
        param: error.invalid_attribute_name,
        status: 400
    end
  end

  # Always keep this below other 'render' methods or it may override your
  # custom 'render' methods.
  def render(error : Lucky::RenderableError)
    Raven.capture(error)
    if html?
      error_html DEFAULT_MESSAGE, status: error.renderable_status
    else
      error_json false, error.renderable_message, status: error.renderable_status
    end
  end

  # If none of the 'render' methods return a response for the raised Exception,
  # Lucky will use this method.
  def default_render(error : Exception) : Lucky::Response
    Raven.capture(error)
    if html?
      error_html DEFAULT_MESSAGE, status: 500
    else
      error_json false, DEFAULT_MESSAGE, status: 500
    end
  end

  private def error_html(message : String, status : Int)
    context.response.status_code = status
    html_with_status Errors::ShowPage, status, message: message, status_code: status
  end

  private def error_json(success : Bool, error : String, status : Int, details = nil, param = nil)
    json ErrorSerializer.new(success: success, error: error, details: details, param: param), status: status
  end

  private def report(error : Exception) : Nil
    # Send to Rollbar, send an email, etc.
  end
end
