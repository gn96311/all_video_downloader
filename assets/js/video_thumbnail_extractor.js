(function() {
    var videoElement = document.querySelector('video[poster]');
    const element = videoElement ? videoElement.getAttribute('poster') : null;
    return JSON.stringify(element);
})();