import 'dart:html';

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
    bodyEl.innerHtml = generateHTML();
  }
  
  getTags(){
    _startingTags = new List();
    _endingTags = new List();
    var openDivs = _original.split('[');
    openDivs.forEach((div){
      List elTag = getElement(div);
      _startingTags.add('<' + elTag[0] + ' ' + elTag[1] + '>');
      _endingTags.add('</' + elTag[0] + '>');
      
    });
  }
  
  getElement(String node){
    List elements = node.split('/');
    List validElements = ["a","abbr","acronym","address","applet","area","article","aside","audio","b","base","basefont","bdi","bdo","bgsound","big","blink","blockquote","body","br","button","canvas","caption","center","cite","code","col","colgroup","content","data","datalist","dd","decorator","del","details","dfn","dir","div","dl","dt","em","embed","fieldset","figcaption","figure","font","footer","form","frame","frameset","h1","h2","h3","h4","h5","h6","head","header","hgroup","hr","i","iframe","img","input","ins","isindex","kbd","keygen","label","legend","li","link","listing","main","map","mark","marquee","menu","menuitem","meta","meter","nav","nobr","noframes","noscript","object","ol","optgroup","option","output","p","param","plaintext","pre","progress","q","rp","rt","ruby","s","samp","section","select","shadow","small","source","spacer","span","strike","strong","sub","summary","sup","table","tbody","td","template","textarea","tfoot","th","thead","time","tr","track","tt","u","ul","var","video","wbr","xmp"];
    
    if(elements.length ==  1){
      return ["div",""];
    }else{
      List elementTypes = elements[0].split(' ');
      int matchingElementIndex = validElements.indexOf(elementTypes[0]);
      String element = validElements[matchingElementIndex];
      elementTypes.removeAt(0);
      return [element,elementTypes.join(' ')];
    }
  }
  
  generateHTML(){
    var openDivs = _original.split('[');
    List generated = new List();
    for(var i=0;i<openDivs.length;i++){
      String stripTags = openDivs[i].split('/').length > 1 ? openDivs[i].split('/')[1] : openDivs[i];
      generated.add(_startingTags[i] + countEnding(stripTags));      
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
