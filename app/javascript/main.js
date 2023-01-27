const LexiNotes = {
  initRequired: function() {
    $('form label.required').each(function() {
      const $this = $(this);

      $this.find('input,textarea').prop('required', 'required');
    });
  },

  initNumericInputs: function() {
    $('input[type="number"]').on('keyup', function(e) {
      const $this = $(this);

      /* stash the value in data-value becuase if non numeric
         given this.value gets blown up entirely

         if there's no this.value, use this.data-value,
         but need to handle the case where the user is trying
         to clear out the field */
      let val = $this.val() || $this.data('value');

      const key = e.originalEvent.key;
      if(!$this.val() && $this.data('value') && $this.data('value').length == 1 && (key == 'Backspace') || key == 'Delete') {
        val = '';
      }

      val?.replace(/[^0-9.]/g, '');
      $this.data('value', val);

      $this.val(val);
    });
  },

  initXHRforms: function(){
    const forms = $('form.xhr');
    forms.each(function() {
      const $this = $(this);
      const action = $this.attr('action') || '/';
      const method = $this.attr('method') || 'get';
      const objName = $this.data('object');
      const methodName = $this.data('method');
      const $that = $this;
      $this.on('submit', function(e) {
        e.preventDefault();
        const formData = $that.serializeArray();

        let queryString = '';
        formData.forEach(function(arg) {
          queryString += `${arg['name']}=${arg['value']}&`
        });

        $.ajax({
          method: method,
          url: action,
          data: queryString,
          headers: {
            Accept: 'application/json'
          },
          complete: function(jqXHR, statusText) {
            window[objName][methodName](jqXHR, statusText, formData);
          }
        });
      });
    });
  },

  init: function() {
    this.initRequired();
    this.initNumericInputs();
    this.initXHRforms();
  }
};

$(document).ready(function() {
  LexiNotes.init();
});
