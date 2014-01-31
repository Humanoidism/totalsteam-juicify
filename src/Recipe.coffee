class Recipe

    constructor: ->
        @liquidAmount = 10
        @dropsPrMl = 25
        @pg = 50
        @vg = 50
        @nicoPGVG = 32
        @nicoTarget = 16
        @water = 0
        @Aromas = {}
        update();

    addAroma: (id, name, value) ->
        @Aromas[id] = {
            name: name,
            value: value
        }
        update();

    removeAroma: (id) ->
        delete @Aromas[id]

    setValueForAroma: (id, value) ->
        @Aromas[id].value = value
        update()

    update: () ->
        @nicoPGVG = (if @nicoPGVG <= 0 then 0 else 100 * @nicoTarget / @nicoPGVG )
        total = 0
        add = (i) -> total += parseInt i.value
        if typeof(@Aromas) == 'object' then add aroma for aroma in @Aromas

        @pg = @pg - ((@nicoPGVG / 2) + ((@water + total) * (@pg/100)))
        @vg = @vg - ((@nicoPGVG / 2) + ((@water + total) * (@vg/100)))



