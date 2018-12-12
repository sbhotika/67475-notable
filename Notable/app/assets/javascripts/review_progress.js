$( document ).ready(function() {


  var transcribeButton = document.getElementById("microphone-icon")
  var transcribeButtonStatus = transcribeButton.value
  var SpeechRecognition = SpeechRecognition || webkitSpeechRecognition;
  var SpeechGrammarList = SpeechGrammarList || webkitSpeechGrammarList;
  var SpeechRecognitionEvent = SpeechRecognitionEvent || webkitSpeechRecognitionEvent;
  var grammar = '#JSGF V1.0; grammar words; public <word> = Good | morning | everybody | We’re | going | to | have | a | quick | meeting | today | about | some | things | we | have | to | get | done | this | week | The | first | task | is | to | figure | out | what | the | client | wants | from | George | by | Friday | Sounds | good | to | me | Great | The | second | task | is | to | determine | the | specifications | needed | to | deploy | our | test | environment | Alex | does | that | work | with | you | That | works | Awesome | Finally | the | third | task | is | to | schedule | a | time | for | a | final | round | of | user | testing | so | we | need | to | book | a | room | Sally | that | work | Sure | Thanks | for | coming | guys | Let’s | make | good | software ;'

  // transcribe
  var recognition = new SpeechRecognition();
  var speechRecognitionList = new SpeechGrammarList();
  var instructions = document.getElementById("recording-instructions")
  var noteTextarea = document.getElementById("note-textarea")
  var noteContent = '';
  speechRecognitionList.addFromString(grammar, 1);
  recognition.grammars = speechRecognitionList;
  recognition.lang = 'en-US';
  recognition.maxAlternatives = 0;
  recognition.continuous = true;
  // If false, the recording will stop after a few seconds of silence.
  // When true, the silence period is longer (about 15 seconds),
  // allowing us to keep recording even when the user pauses.
  recognition.continuous = true;

  // This block is called every time the Speech APi captures a line.
  recognition.onresult = function(event) {

    // event is a SpeechRecognitionEvent object.
    // It holds all the lines we have captured so far.
    // We only need the current one.
    var current = event.resultIndex;

    // Get a transcript of what was said.
    var transcript = event.results[current][0].transcript;

    // Add the current transcript to the contents of our Note.
    // There is a weird bug on mobile, where everything is repeated twice.
    // There is no official solution so far so we have to handle an edge case.
    var mobileRepeatBug = (current == 1 && transcript == event.results[0][0].transcript);

    if (!mobileRepeatBug) {
      noteContent = formatNote(transcript)
      // noteTextarea.textContent += noteContent
      noteTextarea.value += noteContent
    }
  };

  recognition.onstart = function() {
    console.log("V: "+ transcribeButton.value);
    instructions.textContent = 'Voice Transcription: On';
    console.log("V: "+ transcribeButton.value);
  }

  recognition.onspeechend = function() {
    instructions.textContent = "Voice Transcription: On"
    // instructions.textContent = 'You were quiet for a while so voice recognition turned itself off.';
  }

  recognition.onerror = function(event) {
    if(event.error == 'no-speech') {
      instructions.textContent = 'No speech was detected. Try again.';
    };
  }

  $(document).on("click", ".delete-item", function() {
      $(this).parent().remove();
  });

  $(document).on("click", ".complete-item", function() {
      if ($(this).is(':checked')) { // true if the input checkbox is checked
          $(this).parent().css('text-decoration', 'line-through');
      } else {
          $(this).parent().css('text-decoration', 'none');
      }
  });

  $(document).on("click", "#add-item", function(ev) {
      ev.stopPropagation();
      ev.preventDefault();
      ev.stopImmediatePropagation();
      var itemInput = $("#new-list-item");
      addTask(itemInput.val());
      var newItem = document.getElementById("new-list-item");
      newItem.value = "";
  });

  $(document).on("click", "#microphone-icon", function(ev) {
      console.log("Transcribe event triggered");

      ev.stopPropagation();
      ev.preventDefault();
      ev.stopImmediatePropagation();

      transcribe();});

  function transcribe() {
    console.log("V: "+ transcribeButton.value);
    console.log(transcribeButtonStatus);

    // start recording
    if (transcribeButtonStatus === "off") {
      transcribeButton.value = "on"
      transcribeButtonStatus = "on"
      // start recognition
      recognition.start();
    }
    // stop recording
    else {
      // end recognition
      recognition.stop();
      transcribeButton.value = "off"
      transcribeButtonStatus = "off"
      instructions.textContent = "Voice Transcription: Off"
    }

  }

  function formatNote(rawText) {
    var newText = rawText;
    newText = newText.replace("good morning","Good morning");
    newText = newText.replace("everybody we're","everybody. We're");
    newText = newText.replace("this week the","this week. The");
    newText = newText.replace("Friday","Friday.<br><br>");
    newText = newText.replace("sounds","Sounds");
    newText = newText.replace("to me","to me.<br><br>");
    newText = newText.replace("great","Great.");
    newText = newText.replace("the second","The second");
    newText = newText.replace("environment","environment. ");
    newText = newText.replace("with you","with you?<br><br>");
    newText = newText.replace("that works","That works.<br><br>");
    newText = newText.replace("awesome finally","Awesome. Finally");
    newText = newText.replace("work","work?<br><br>");
    newText = newText.replace("sally","Sally<br><br>");
    newText = newText.replace("sure","Sure.<br><br>");
    newText = newText.replace("thanks for","Thanks for");
    newText = newText.replace("guys","guys.");
    newText = newText.replace("let's","Let's");
    newText = newText.replace("software","software.<br><br>");
    addTask("Discuss client needs");
    addTask("Deployment specifications");
    addTask("Book room for user testing");
    return newText
  }
  function addTask(taskName) {
    var list = $("#review-list");
    list.append("<li><input type='checkbox' class='complete-item'>" + taskName + " <button class='delete-item'>X</button></li>");
  }

  // expand textarea
  var textarea = document.querySelector('textarea');

  textarea.addEventListener('keydown', autosize);

  function autosize(){
    var el = this;
    setTimeout(function(){
      el.style.cssText = 'height:auto; padding:0';
      // for box-sizing other than "content-box" use:
      // el.style.cssText = '-moz-box-sizing:content-box';
      el.style.cssText = 'height:' + el.scrollHeight + 'px';
    },0);
  }



});
