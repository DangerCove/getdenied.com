'use strict'

class RulesManager {
  constructor(el) {
    this.el = el;

    this._bindFileUpload();
  }

  _bindFileUpload() {
    var fileContainer = this.el.getElementsByClassName('rules-manager__button-container--load')[0];
    var fileLink = fileContainer.getElementsByClassName('rules-manager__load')[0];
    var fileButton = fileContainer.getElementsByClassName('rules-manager__file')[0];

    fileLink.addEventListener('click', function(e) {
      e.preventDefault();
      fileButton.click();
    });
  }
}

// Activate
(function() {
  var elements = document.getElementsByClassName('rules-manager');
  console.log(elements);
  for (var i = 0; i < elements.length; i++) { 
    var el = elements[i];
    var rulesManager = new RulesManager(el);
  }
})();
