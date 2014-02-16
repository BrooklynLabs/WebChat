(->
  $('body').chardinJs('start')
  if window.webkitRTCPeerConnection
    room = location.pathname.replace(/^\//, "")
    console.log(room)
    webrtc = new SimpleWebRTC(
      localVideoEl: "localVideo"
      remoteVideosEl: "remotesVideos"
      autoRequestMedia: true
    )
    webrtc.on "videoAdded", ->
      $("video#placeholder").hide()
      return

    webrtc.on "videoRemoved", ->
      $("video#placeholder").show()  if $("#remotesVideos video").length is 1
      return

    webrtc.on "readyToCall", ->
      webrtc.joinRoom room  if room
      return

    $("form").submit ->
      val = $("#roomName").val().toLowerCase().replace(/\s/g, "").replace(/[^A-Za-z0-9_\-]/g, "")
      webrtc.createRoom val, (err, name) ->
        newUrl = location.pathname.replace(/\/$/, "") + "/" + name
        unless err
          window.location = newUrl
        return
      false
  # end if window.webkitRTCPeerConnection
  else
    alert "Currently only Chrome browser is supported for Video Conferencing without installing any Plugins or using Adobe Flash. It is using WebRTC for realtime video."

  return
)()