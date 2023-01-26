const Notes = {
  initAddNoteButtons: function() {
    const that = this;
    this.addNoteButtons.on('click', function() {
      that.noteModal.show();
    })
  },

  initNoteModal: function() {
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
