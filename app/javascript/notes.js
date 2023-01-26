const Notes = {
  initAddNoteButtons: function() {
    const that = this;
    this.addNoteButtons.on('click', function() {
      that.noteModal.show();
    })
  },

  initNoteModal: function() {
  },

  init: function() {
    this.notes = $('#notes tbody tr');
    this.noteModal = $('#note-modal');
    this.addNoteButtons = $('.add-note');

    this.initAddNoteButtons();
    this.initNoteModal();
  }
};

$(document).ready(function() {
  Notes.init();
});
