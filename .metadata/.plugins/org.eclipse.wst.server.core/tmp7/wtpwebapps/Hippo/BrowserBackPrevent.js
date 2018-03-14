/**
 * ブラウザバックを行わせないためのjs
 */

window.onunload = function() {};/*FireFox用*/
history.forward();/*IE,Chrome用*/