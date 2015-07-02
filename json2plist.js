	var XMLWriter = require('xml-writer')
	var fs=require("fs")

	function readJson(fileName){
		fs.readFile(fileName+'.json','utf-8', function(err,data){ 
		if(err){ 
		  	console.log(err)
		}else{ 
		  	var json=JSON.parse(data)
		  	json=addProperties(json,fileName)
			var xml = new XMLWriter()
			xml.startDocument()
			xml.writeDocType('plist', "-//Apple Computer//DTD PLIST 1.0//EN", "http://www.apple.com/DTDs/PropertyList-1.0.dtd");

			xml.startElement('plist')
			xml.writeAttribute('version',"1.0")
			xml.startElement('dict')
		  	parsetoXML(xml,json)

			xml.endElement()
			xml.endElement()
		  	xml.endDocument()

			fs.writeFile(fileName+'.plist',xml.toString())
		} 
		})
	}

	function parsetoXML(xml,json){
		for ( var key in json ){
			var value=json[key]
	  		if(typeof value=="object"){
	  			xml.startElement('key')
	  			xml.text(key)
	  			xml.endElement()

	  			if(key=='frame' || key=='offset' || key=='sourceColorRect' || key=='sourceSize' || key=='spriteSourceSize'){
	  				parsetoJson(xml,value)
	  			}else{
	  				xml.startElement('dict')
	  				parsetoXML(xml,value)
	  				xml.endElement()
	  			}
	  		}else{
				toXML(xml,key,value) 
	  		}
		}
		
	}

	function toXML(xml,key,value){
		xml.startElement('key')
		xml.text(key)
		xml.endElement()
		if(typeof value == 'boolean'){
			xml.startElement(value.toString())
		}else{
			xml.startElement('string')
			xml.text(value.toString())
		}
		xml.endElement()
	}

	function parsetoJson(xml,value){
		xml.startElement('string')
		var json='{'+value.w+','+value.h+'}'
		if(value.x!=undefined && value.w!=undefined){
			json='{{'+value.x+','+value.y+'},{'+value.w+','+value.h+'}}'
		}
		xml.text(json)
		xml.endElement()
	}

	function addProperties(json,fileName){

		for(var key in json.frames){
			json.frames[key+".png"]=json.frames[key]
			delete json.frames[key]
		}
		var metadata={format:2,realTextureFileName:fileName+'.png',size:sizeof(fileName),smartupdate:'$TexturePacker:SmartUpdate:'+uuid()+'$',textureFileName:fileName+'.png'}
		json['metadata']=metadata
		delete json['meta']

		return json
	}

	function uuid(){
		var uuid=require('uuid')
		return uuid.v1()
	}

	function sizeof(fileName){
		var imageinfo = require('imageinfo');
		var filedata=fs.readFileSync(fileName+'.png')
		var info=imageinfo(filedata)
		return '{'+info.width+','+info.height+'}'
	}

	var arguments = process.argv.splice(2);
	readJson(arguments[0])
