# OUTPUT
# [
#   {
#       fieldName: <fieldName (e.g. baseNikotin>,
#       ml: 0,
#       drops: 0,
#       percentage: 1.0
#   }
# ]
#
# INPUT
# {
#   liqAmount: {
#       name: 'Liquid Amount'
#       value: 100,
#       unit: 'ml'
#   },
#   aromas: [
#       {
#           name: 'Aroma name'
#           value: 100
#       }
#   ]
# }
#
# {
#     nicoStr: 10,
#     nicoPGVG: 80,
#     water: 15,
#     pg: 50,
#     vg: 50,
#     aromas: [
#         { value: 5 },
#         { value: 5 }
#     ]
# }

class Recipe
    constructor: () ->
        @ingredients = []

    addIngredient: (@options) ->
        id = @options.id ? undefined
        name = @options.name ? 'N/A'
        drops = @options.drops ? 0
        liquidAmount = @options.liquidAmount ? 0
        percentage = @options.percentage ? 0

        _ref = {
            id: id,
            name: name,
            liquidAmount: percentage / liquidAmount,
            drops: liquidAmount * drops,
            percentage: percentage
        }

        @ingredients.push _ref

        return _ref

    getIngredient: (id) ->
        (ingredient for ingredient in @ingredients when ingredient.id is id)


    updateIngredient: (id, percentage) ->
        for key, ingredient of @ingredients
            (ingredient.percentage = percentage) if ingredient.id is id
        return

    removeIngredient: (index) ->
        @ingredients.splice index, 1

class Blender

    constructor: (@fields) ->
        @recipe = new Recipe()
        @base = (if @fields.nicoPGVG <= 0 then 0 else 100 * (@fields.nicoStr / @fields.nicoPGVG))
        total = 0
        add = (i) -> total += parseInt i.value
        if typeof(@fields.aromas) == 'object' then add aroma for aroma in @fields.aromas

        @pg = @fields.pg - ((@base / 2) + ((@fields.water + total) * (@fields.pg/100)))
        @vg = @fields.vg - ((@base / 2) + ((@fields.water + total) * (@fields.vg/100)))
        return

    addIngredient: (id, name, percentage) ->
        @recipe.addIngredient {
            id: id
            name: name,
            liquidAmount: @fields.liquidAmount,
            drops: @fields.drops,
            percentage: percentage
        }

