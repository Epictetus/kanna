$ ->
  beforeAjaxRequest = (xhr, settings) ->
    beforeAjaxSetup(xhr, settings)

  afterAjaxRequest = () ->
    reWriteImageSrc()

  cancelInvalidUrlRequest = (url) ->
    return url.length == 0 || url.match(/^file/) || url == "#" || url == "javascript:void(0)"

  beforeAjaxSetup = (xhr, settings) ->
    if cancelInvalidUrlRequest(settings.url)
      console.log "cancel ajax request on beforeAjaxSetup - url: " + settings.url
      return false

    if settings.url && !settings.url.match(/^http/)
      settings.url = hostUrl + settings.url

    settings.crossDomain = true
    xhr.setRequestHeader("Accept", "text/javascript, application/javascript, application/ecmascript, application/x-ecmascript")
    xhr.setRequestHeader("X-PERA", "v1")
    true

  reWriteImageSrc = ->
    $('img[src^="/"]').each ->
      $(this).attr 'src', hostUrl + $(this).attr('src')

  $('form, a')
  .live 'ajax:beforeSend', (event, xhr, settings) ->
    beforeAjaxRequest(xhr, settings)
  .live 'ajax:error', (event, xhr, status, error) ->
    if(error == "Unauthorized")
      console.log("[ajax:error] Unauthorized")
      alert(xhr.responseText)
    else
      console.log("[ajax:error] Error")
      console.log('[status]: ' + error)
      console.log('[xhr.statusText]: ' + xhr.statusText)
      console.log('[this]: ' + this)
      console.log('[this.id]: ' + this.id)
      console.log('[this.action || this.href]: ' + (this.action || this.href))
      debugger
      alert("[Ajax Error]" + error)
  .live 'ajax:complete', (event, xhr, status) ->
    afterAjaxRequest()

  $.peraGet = (url, callback) ->
    $.ajax
      type: "GET",
      url: url,
      beforeSend: beforeAjaxRequest
      complete: ->
        afterAjaxRequest()
        if callback
          callback.call()
