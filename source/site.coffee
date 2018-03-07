require 'normalize.css'
{h,render,Component} = require 'preact'
{Box,Shader} = require 'shader-box'
Markdown = require 'preact-markdown'
require './site.less'

EXAMPLES = []
PROPS = [
	['(any preact-slide prop)','',' any preact slide prop will be passed down to the outer component']
	['toggle','','toggle true / false']
	['onToggle','','toggle callback on / off']
	['className','','outer css class']
	['barClass', '','bar class']
	['barBeta', '','set optional bar beta, set to 0 disable and just have a sliding toggle button']
	['trueClass', '','on div style class']
	['falseClass', '','off div style class']
	['disabled', '','disabled toggle mouse events']
	['falseChild', '','off child(s) / string']
	['trueChild', '','on child(s) / string']
]

SlideToggle = require './preact-slide-toggle.coffee'

TITLE = 'Toggle'
SAMPLE = require './sample.coffee'
BODY = require './BODY.md'

class Header extends Component
	constructor: ->
		super()
		@state =
			title_snippet_pos_a: 0
			title_snippet_pos_b: 1
			show_bg: true
	
	componentDidMount: ->
		@t = Math.random()*10000
		@box = new Box
			canvas: @_canvas
			resize: true #auto resize on window.resize
			clearColor: [0.0, 0.0, 0.0, 1.0]
			context:
				antialias: false
				depth: false
		@gradient = new Shader
			code: require('./gradient.glsl')
			uniforms:
				pos:
					type:'2fv'
					val: [0.5,0.5]
				seed:
					type:'3fv'
					val: [0.6,0.2,2.2]
				speed:
					type:'1f'
					val:1.0
				fade:
					type:'1f'
					val:1.5
				iTime:
					type:'1f'
					val: @t

		@box.add(@gradient)
		@box.clear().draw(@gradient)
		@tick(@t)
		
	
	tick: ()=>
		requestAnimationFrame(@tick)
		if window.scrollY > window.innerHeight && @state.show_bg
			@setState
				show_bg: false
		else if window.scrollY < window.innerHeight && !@state.show_bg
			@setState
				show_bg: true
		if !@state.show_bg
			return
		@gradient.uniforms.iTime.val = @t+=10
		@box.clear().draw(@gradient)
		


	render: ->
		h 'div',
			className: 'header'
			h 'canvas',
				style:
					visibility: !@state.show_bg && 'hidden' || null
				className: 'canvas'
				ref: (el)=>
					@_canvas = el
			h 'a',
				className: 'gradient-link center'
				href: 'https://github.com/arxii/shader-box-gradient'
				'?'

			h 'div',
				className: 'header-description',
				h 'div',
					className: 'title center'
					h 'a',
						href: "https://github.com/arxii/preact-slide"
						className: 'title-name'
						TITLE
					h SAMPLE
					h 'a',
						href: "https://github.com/arxii/preact-slide"
						className: 'center github-link'
						h 'img',
							src: './dist/site/github.svg'
				h 'p',
					className:'header-description-sub'
					'About'
				h 'p',
					className:'header-description-text'
					h Markdown,
						markupOpts:
							className: 'section-text'
						markdown: ABOUT
					h 'div',
						className: 'shields'
						h 'a',
							href:'https://npmjs.com/package/preact-slide'
							h 'img',
								src: 'https://img.shields.io/npm/v/preact-slide.svg?style=for-the-badge'
						h 'a',
							href:'https://travis-ci.org/arxii/preact-slide'
							h 'img',
								src: 'https://img.shields.io/travis/arxii/preact-slide.svg?style=for-the-badge'



ABOUT = require './ABOUT.md'

class Docs 
	render: ->
		examples = EXAMPLES.length && h 'div',
			className: 'examples section'
			h 'h1',
				margin: 10
				'Examples'
			EXAMPLES.map (example)->
				h 'div',
					className: 'example-section'
					h 'a',
						href: example[3]
						target: '_blank'
						className: 'section-title'
						h 'span',
							className: 'section-title-name'
							example[0]
					h Markdown,
						markdown: example[1]
						markupOpts:
							className: 'section-text'
					h example[2]
					example[3] && h 'a',
						href: example[3]
						className: 'section-title-link'
						target: '_blank'
						'</>'
		props = PROPS.length && h 'div',
			className: 'section'
			h 'h1',{},'Props'
			PROPS.map (prop)->
				h 'div',
					className: 'prop'
					h 'div',
						className: 'prop-name'
						prop[0]
					h 'div',
						className: 'prop-default'
						prop[1]
					h Markdown,
						markdown: prop[2]
						markupOpts:
							className: 'prop-text'

		body = BODY && h Markdown,
			markdown: BODY
			markupOpts:
				className: 'section'



		h 'div',
			className: 'docs'
			h Header
			props || null
			body || null
			examples || null
			
			h 'footer',
				className: 'footer'
				h 'a',
					href: "https://github.com/arxii/preact-slide-toggle"
					className: 'footer-text'
					'Source'
				h 'a',
					href: "https://github.com/arxii/preact-slide-toggle/blob/master/LICENSE"
					className: 'footer-text'
					'Apache License 2.0'




@docs_el = null
render(h(Docs),document.body,@docs_el)
# hljs.initHighlightingOnLoad()



