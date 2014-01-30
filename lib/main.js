// Generated by CoffeeScript 1.6.3
var $dataTable, action, add, aromas, blnd, getField, init, remove, setField, update;

aromas = [];

blnd = null;

$dataTable = void 0;

init = function() {
  $dataTable = $('#blender-data');
  blnd = new Blender({
    nicoStr: 0,
    nicoPGVG: 0,
    water: 0,
    pg: 0,
    vg: 0,
    liquidAmount: 5,
    drops: 0
  });
  blnd.addIngredient('nikotin-pgvg', 'Nikotin PG/VG', blnd.base);
  blnd.addIngredient('vg', 'VG', blnd.vg);
  blnd.addIngredient('pg', 'PG', blnd.pg);
  return blnd.addIngredient('water', 'Vand/Fortynder', blnd.fields.water);
};

add = function(e) {
  var $aroma, $aromas, aroma, aromaID, aromaName, aromaValue, html;
  e.preventDefault();
  aromaName = $('input-aromaname').val();
  aromaValue = $('input-aromavalue').val();
  $aromas = $('.aromas');
  aromaID = aromas.length < 1 ? 0 : aromas.length;
  aroma = blnd.addIngredient("aroma-" + aromaID, "Aroma " + aromaID, 0);
  aromas.push(aroma);
  html = "<div class=\"form-group\" id=\"" + aroma.id + "\">            <div class=\"col-sm-2\">                <input type=\"text\" class=\"form-control control-label\" id=\"input-" + aroma.id + "\" placeholder=\"Aroma " + aromaID + "\">            </div>            <div class=\"col-sm-1\">                <input type=\"text\" class=\"form-control\" id=\"input-" + aroma.id + "\" value=\"" + aroma.percentage + "\">            </div>            <div class=\"col-sm-1\">                <p class=\"form-control-static\">%</p>            </div>            <div class=\"col-sm-5\">                <button tabindex=\"-1\" class=\"btn btn-danger btn-sm\"><span class=\"glyphicon glyphicon-remove\" style=\"vertical-align: -1px\"></span></button>            </div>        </div>";
  $aromas.append(html);
  $aroma = $("#" + aroma.id + " button");
  $aroma.on('click', function(e) {
    e.preventDefault();
    return remove(e);
  });
  html = "";
  html += "<tr id=\"recipe-" + aroma.id + "\">";
  html += "<th data-field=\"name\">" + aroma.name + "</th>";
  html += "<td data-field=\"liquidAmount\">" + aroma.liquidAmount + "</td>";
  html += "<td data-field=\"drops\">" + aroma.drops + "</td>";
  html += "<td data-field=\"percentage\">" + aroma.percentage + "</td>";
  html += "</tr>";
  return $dataTable.find('tbody').append(html);
};

remove = function(e) {
  var elm, elmID;
  e.preventDefault();
  elm = $(e.target).parents('.form-group');
  elmID = parseInt(elm.attr('id').replace('aroma-', ''));
  aromas.splice(parseInt(elmID), 1);
  blnd.recipe.removeIngredient(elmID);
  $("#recipe-" + (elm.attr('id'))).remove();
  return elm.remove();
};

update = function(e) {
  var $elm, name;
  e.preventDefault();
  $elm = $(e.target);
  name = $elm.attr('id').replace('input-', '');
  blnd.recipe.updateIngredient(name, parseInt($elm.val()));
  console.log(blnd.recipe.ingredients);
  return setField("recipe-" + ($(e.target).attr('id')), {
    liquidAmount: 'HELLO WORLD',
    drops: 'LOL'
  });
};

action = function(actionName) {
  return $("[data-action=\"" + actionName + "\"]");
};

getField = function(id, fieldName) {
  return $("#" + id).find("[data-field=\"" + fieldName + "\"]");
};

setField = function(id, data) {
  var field, value;
  for (field in data) {
    value = data[field];
    getField(id, field).text(value);
  }
};

$(function() {
  var html;
  init();
  html = "";
  $.each(blnd.recipe.ingredients, function(i, v) {
    html += "<tr id=\"recipe-" + v.id + "\">";
    html += "<th data-field=\"name\">" + v.name + "</th>";
    html += "<td data-field=\"liquidAmount\">" + v.liquidAmount + "</td>";
    html += "<td data-field=\"drops\">" + v.drops + "</td>";
    html += "<td data-field=\"percentage\">" + v.percentage + "</td>";
    return html += "</tr>";
  });
  $dataTable.find('tbody').html(html);
  action('update').on('blur', update);
  return action('add').on('click', add);
});