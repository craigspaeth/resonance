$ ->
  $('.social-nav a').click (e) ->
    e.preventDefault()

    width = 750
    height = 400
    $target = $(e.currentTarget)
    $window = $(window)
    wLeft = window?.screenLeft or window.screenX
    wTop = window?.screenTop or window.screenY

    options =
      status: 1
      width: width
      height: height
      top: (wTop + ($window.height() / 2) - (height / 2)) or 0
      left: (wLeft + ($window.width() / 2) - (width / 2)) or 0

    opts = ("#{key}=#{value}" for key, value of options).join ','
    window.open $target.attr('href'), $target.data('service'), opts
