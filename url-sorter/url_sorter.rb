class UrlSorter

  def sort_url(url)

    sorted_url = ''

    prefix, query_string = url.split('?')

    if query_string
      params_strings = query_string.split('&')
      params = params_strings.map { |param_string| param_string.split('=') }
      sorted_params = params.sort_by { |param| [param[0], param[1]] }

      sorted_url = "#{ prefix }?#{ sorted_params.map{ |sorted_param| sorted_param.join('=') }.join('&') }"
    else
      sorted_url = prefix.to_s
    end

    sorted_url

  end
end
