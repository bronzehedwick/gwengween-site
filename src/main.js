(function main() {
  'use strict';

  window.addEventListener('scroll', function scroll(event) {
    console.count('scroll');
  }, {passive: true});

})();
