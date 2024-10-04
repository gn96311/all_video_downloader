(function() {
  var originalFetch = window.fetch;
  window.fetch = function() {
    return originalFetch.apply(this, arguments).then(response => {
      if (response.url.includes('script.html')) {
        window.flutter_inappwebview.callHandler('captureScriptHtml', response.url);
      }
      return response;
    });
  };

  var originalXHR = window.XMLHttpRequest.prototype.open;
  window.XMLHttpRequest.prototype.open = function(method, url) {
    if (url.includes('script.html')) {
      window.flutter_inappwebview.callHandler('captureScriptHtml', url);
    }
    return originalXHR.apply(this, arguments);
  };
})();
