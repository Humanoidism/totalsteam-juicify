aromas = []
blnd = null
$dataTable = undefined

# Initializer
init = () ->
    $dataTable = $('#blender-data')
    blnd = new Blender()
    updateDOM()

add = (e) ->
    e.preventDefault()
    aromaName = $('input-aromaname').val()
    aromaValue = $('input-aromavalue').val()
    $aromas = $('.aromas')
    aromaID = if aromas.length < 1 then 0 else aromas.length

    aroma = blnd.addAroma("aroma-#{aromaID}", "Aroma #{aromaID}", 0)
    aromas.push(aroma)

    html = "<div class=\"form-group\" id=\"#{aroma.id}\">
            <div class=\"col-sm-2\">
                <input type=\"text\" class=\"form-control control-label\" id=\"input-#{aroma.id}-name\" placeholder=\"Aroma #{aromaID}\">
            </div>
            <div class=\"col-sm-1\">
                <input type=\"text\" class=\"form-control\" id=\"input-#{aroma.id}\" value=\"#{aroma.value}\">
            </div>
            <div class=\"col-sm-1\">
                <p class=\"form-control-static\">%</p>
            </div>
            <div class=\"col-sm-5\">
                <button tabindex=\"-1\" class=\"btn btn-danger btn-sm\"><span class=\"glyphicon glyphicon-remove\" style=\"vertical-align: -1px\"></span></button>
            </div>
        </div>"
    $aromas.append(html);

    $aroma = $("##{aroma.id}")
    $aroma.find('button').on 'click', remove
    $aroma.find("input").on 'blur', update

remove = (e) ->
    e.preventDefault()
    elm = $(e.target).parents('.form-group')
    elmID = parseInt(elm.attr('id').replace('aroma-', ''))

    aromas.splice parseInt(elmID), 1
    blnd.removeAroma(elm.attr('id'))
    updateDOM()

    $("#recipe-#{elm.attr('id')}").remove()
    elm.remove()



update = (e) ->
    e.preventDefault()
    $elm = $(e.target)
    id = $elm.attr('id').replace('input-', '')
    val = $elm.val();

    _IDtokens = id.split('-')

    if _IDtokens[2]
        blnd.setAroma(id.replace('-name', ''), { name: val })
    else if _IDtokens[0] == 'aroma'
        blnd.setAroma(id, { value: parseInt(val) })
    else
        blnd[id] = parseInt(val)

    updateDOM()

    console.log blnd

# Action selector
action = (actionName) ->
    $("[data-action=\"#{actionName}\"]")

getField = (id, fieldName) ->
    $("#recipe-#{id}").find("[data-field=\"#{fieldName}\"]")

# setField('recipe-0', {liquidAmount: '10.0'})
setField = (id, data) ->
    getField(id, field).text(value) for field, value of data
    return

updateDOM = () ->
    html = ""
    $.each blnd.getIngredients(), (i, v) ->
        html += "<tr id=\"recipe-#{i}\">"
        html += "<th data-field=\"name\">#{v.name}</th>"
        html += "<td data-field=\"drops\">#{v.drops}</td>"
        html += "<td data-field=\"liquidAmount\">#{v.value}</td>"
        html += "<td data-field=\"percentage\">#{v.percentage}</td>"
        html += "</tr>"
    $dataTable.find('tbody').html(html);

$ ->
    init()

    # on update action
    action('update').on 'blur', update

    # on add action
    action('add').on 'click', add
