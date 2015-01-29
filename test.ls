'use strict';
require! tape
used = require \./index

tape 'simple', (test) ->
    test.plan 1
    test.deepEqual used('{{hello.world}}'), do
        hello: 1

tape 'sections and else', (test) ->
    test.plan 1
    test.deepEqual used('{{hello.world}}{{#a}}{{b}}{{else}}{{c}}{{/a}}'), do
        hello: 1
        a: 1
        b: 1
        c: 1

tape 'element', (test) ->
    test.plan 1
    test.deepEqual used('<div id={{hi.there}} {{hello.world}} {{#a}}class={{b}}{{else}}{{c}}{{/a}}></div>'), do
        hello: 1
        a: 1
        b: 1
        c: 1

tape 'partial', (test) ->
    test.plan 1
    test.deepEqual used('{{>p}}', {p: '<div id={{hi.there}} {{hello.world}} {{#a}}class={{b}}{{else}}{{c}}{{/a}}></div>'}), do
        hello: 1
        a: 1
        b: 1
        c: 1
