window.Notes = {
  updateNotes: function(jqXHR, statusText, formData) {
    if(statusText == 'error') {
      // todo: handle errors
      return;
    }
    console.log(jqXHR.responseJSON);
  },

  initAddNoteButtons: function() {
    const that = this;
    this.addNoteButtons.on('click', function() {
      that.noteModal.show();
    })
  },

  initNoteModal: function() {
    // TODO: require all book/chapter/verse if any set
    const that = this;
    this.modalCancelButton.on('click', function(e) {
      e.preventDefault();
      that.noteModal.hide();
      that.noteModal.find('input,textarea').val(function() {
        if(this.type == 'submit') {
          return this.value;
        }
        else {
          return '';
        }
      });
      that.noteModal.find('input,textarea').data('value', '');
    });
  },

  init: function() {
    this.notes = $('#notes tbody tr');
    this.noteModal = $('#note-modal');
    this.addNoteButtons = $('.add-note');
    this.modalCancelButton = this.noteModal.find('button.cancel');

    this.initAddNoteButtons();
    this.initNoteModal();
  }
};

$(document).ready(function() {
  Notes.init();
});
