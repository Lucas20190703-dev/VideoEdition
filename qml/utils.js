function timeStringFromMilliSeconds(t) {
    let secs = Math.round(t / 1000)

    var h = Math.floor(secs / 3600)
    var m = Math.floor((secs - h * 3600) / 60)
    var s = secs - h * 3600 - m * 60
    var str = ""
    if (h < 10) str += '0' + h
    else str += h

    str += ":"
    if (m < 10) str += '0' + m
    else str += m

    str += ":"
    if (s < 10) str += '0' + s
    else str += s
    return str
}
