import 'dart:html';
import 'dart:convert';

void main() {
  new ParseDocument(bodyEl: querySelector('.cylon'));
}

class ParseDocument{
  String _original;
  List _startingTags;
  List _endingTags;
  
  ParseDocument({bodyEl}){
    _original = bodyEl.text;
    getTags();
    bodyEl.children.add(new HtmlEscape().convert(generateHTML()));
  }
  
  getTags(){
    _startingTags = new List();
    _endingTags = new List();
    var openDivs = _original.split('[');
    openDivs.forEach((div){
      String elTag = getElement(div.toString());
      _startingTags.add('<' + elTag + '>');
      _endingTags.add('</' + elTag + '>');
    });
  }
  
  getElement(String node){
    return "div";
  }
  
  generateHTML(){
    var openDivs = _original.split('[');
    List generated = new List();
    for(var i=0;i<openDivs.length;i++){
      generated.add(_startingTags[i] + countEnding(openDivs[i]));      
    };
    return generated.join();
  }
  
  countEnding(element){
    var closing = element.split(']');
    for(var i=0;i<closing.length;i++){
      if(i>0){
        closing[i] = _endingTags[0];
        _endingTags.removeAt(0);
      }
    }
    return closing.join();
    
  }
  
}
