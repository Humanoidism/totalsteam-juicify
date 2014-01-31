class Blender

    constructor: ->
        @liquidAmount = 10.0
        @dropsPrMl = 25.0
        @pg = 50.0
        @vg = 50.0
        @nicoPGVG = 20.0
        @nicoTarget = 10.0
        @water = 15.0
        @Aromas = {}

    addAroma: (id, name, value) ->
        @Aromas[id] = {
            id: id
            name: name,
            value: value
        }

    removeAroma: (id) ->
        delete @Aromas[id]
        return

    setAroma: (id, data) ->
        @Aromas[id].value = data.value or @Aromas[id].value
        @Aromas[id].name = data.name or @Aromas[id].name
        return

    updatedBase: () ->
        total = 0
        add = (i) -> total += parseInt i.value, 0
        add aroma for key, aroma of @Aromas if typeof(@Aromas) == 'object'
        _nicoPGVG =  parseInt((if @nicoPGVG <= 0 then 0 else 100 * @nicoTarget / @nicoPGVG ))
        _ref = {
            nicoPGVG: parseInt(_nicoPGVG),
            pg: parseInt(@pg - ((_nicoPGVG / 2) + ((parseInt(@water) + total) * (@pg/100)))),
            vg: parseInt(@vg - ((_nicoPGVG / 2) + ((parseInt(@water) + total) * (@vg/100))))
        }
        _ref

    getIngredients: () ->
        _ref = [
            {
                name: "nicoPGVG",
                percentage: parseInt(@updatedBase().nicoPGVG)
                value: parseInt(@updatedBase().nicoPGVG/@liquidAmount),
                drops: parseInt(@updatedBase().nicoPGVG/@liquidAmount * @dropsPrMl)
            },
            {
                name: "PG",
                percentage: parseInt(@updatedBase().pg),
                value: parseInt(@updatedBase().pg/@liquidAmount),
                drops: parseInt(@updatedBase().pg/@liquidAmount * @dropsPrMl)
            },
            {
                name: "VG",
                percentage: parseInt(@updatedBase().vg),
                value: parseInt(@updatedBase().vg/@liquidAmount),
                drops: parseInt(@updatedBase().vg/@liquidAmount * @dropsPrMl)
            },
            {
                name: "water",
                percentage: parseInt(@water)
                value: parseInt(@water/@liquidAmount),
                drops: parseInt(@water/@liquidAmount * @dropsPrMl)
            }
        ]

        (
          _aroma = {}
          _aroma.id = aroma.id
          _aroma.name = aroma.name
          _aroma.percentage = aroma.value
          _aroma.value = aroma.value/@liquidAmount
          _aroma.drops = aroma.value/@liquidAmount * @dropsPrMl
          _ref.push _aroma
        ) for key, aroma of @Aromas

        _ref



