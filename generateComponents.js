var fs = require('fs');

function findModuleFiles(_name) {
  var totalList = fs.readdirSync("src/modules").map(function (file) {
    return "../../modules/" + file
  }).concat(fs.readdirSync("src/layout").map(function (file) {
    return "../../layout/" + file
  })).concat(fs.readdirSync("src/states").map(function (file) {
    return "../../states/" + file
  }));

  var fileList = [];
  for (index in totalList) {
    var file = totalList[index];
    if("_" + file.split("_")[1] == _name){
      fileList.push(file);
    }
  }
  return fileList
}

function findDependency() {
  var mixinsList = fs.readdirSync("src/mixins").map(function (file) {
    return "../../mixins/" + file
  });
  var variablesList = fs.readdirSync("src/variables").map(function (file) {
    return "../../variables/" + file
  });
  var totalList = variablesList.concat(mixinsList);

  totalList.push("../../_base.scss")

  return totalList
}

function outputFile(_list, _path){
  var _nameList = _list.map(function (file) {
    return '@import "' + file + '"'
  });
  var _str = _nameList.join(';\n');
  fs.writeFile(_path, _str, function (err) {
    if(err){console.log("write file" + _path + "error: " + err)}
  });
}

(function main(argument) {
  var totalList = fs.readdirSync("src/layout").concat(fs.readdirSync("src/modules"));
  totalList.push("_state.scss");
  for(index in totalList){
    var file = totalList[index];
    var nameList = findDependency().concat(findModuleFiles(file));
    outputFile(nameList, "src/tmp/components/" + file);
  }
}).call(this);
