var css = ".container {position: relative; width: 100%; height: 0; padding-bottom: 56.25%;} .video { position: absolute; top: 0; left: 0; width: 100%; height: 100%;}"

var styleNode = document.createElement('style');
styleNode.type = 'text/css';
var styleText = document.createTextNode(css);
styleNode.appendChild(styleText);
document.getElementsByTagName('head')[0].appendChild(styleNode);
window.webkit.messageHandlers.GetHeight.postMessage(css);

