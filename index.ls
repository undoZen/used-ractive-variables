'use strict';
Ractive = require \ractive

module.exports = variablesMaybeUsed
function variablesMaybeUsed(template, partials)
    unless template
        return {}
    partials ||= {}
    parsed = if typeof template is 'string' then Ractive.parse(template) else template
    result = {}
    walk(parsed.t, partials, result)
    return result

function walk(f, p, result)
    f.forEach (c) ->
        if c.t is 2
            addReference(c, result)
        else if c.t is 4
            addReference(c, result)
            if (c.f?length)
                walk(c.f, p, result)
            if (c.l?length)
                walk(c.l, p, result)
        else if c.t is 7
            if c.a and Object.keys(c.a).length
                walk([v for own k,v of c.a], p, result)
            if c.m
                walk(c.m, p, result)
            if (c.f?length)
                walk(c.f, p, result)
        else if c.t is 8
            if c.r
                result <<< variablesMaybeUsed(p[c.r] || '')

function firstPart(r)
    r.split('.')[0]

function addReference(c, result)
    if c.r
        result[firstPart(c.r)] = 1
    else if c.x
        c.x.r.forEach (r) ->
            result[firstPart(r)] = 1
    else if c.rx?r
        result[firstPart(c.rx.r)] = 1
