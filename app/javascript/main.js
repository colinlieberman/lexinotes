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

      val.replace(/[^0-9.]/g, '');
      $this.data('value', val)

      $this.val(val);
    });
  },

  init: function() {
    this.initRequired();
    this.initNumericInputs();
  }
};

$(document).ready(function() {
  LexiNotes.init();
});
