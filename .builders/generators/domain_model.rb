KManager.action :domain_model do
  action do

    DrawioDsl::Drawio
      .init(k_builder, on_exist: :write, on_action: :execute)
      .diagram(theme: :style_04)
      .page('Domain Modal', margin_left: 0, margin_top: 0, rounded: 0, background: '#fafafa') do
        grid_layout(wrap_at: 6, grid_w: 180, grid_h: 180)

        shape_element = :rectangle2 # hexagon, diamond, ellipse
        shape_element_w = 75
        shape_element_h = 50
        shape_element_theme = :style_03

        # need a blank
        # square(fill_color: '#fafafa', stroke_color: '#fafafa', font_color: '#333333')

        square(title: 'Configuration', theme: :style_01)

        klass(description: '') do
          format
            .header('ShapeDefaults')
            .field(:type, type: :symbol)
            .field(:category, type: :symbol)
            .field(:x, type: :integer)
            .field(:y, type: :integer)
            .field(:w, type: :integer)
            .field(:h, type: :integer)
            .field(:style_modifiers, type: :string)
        end

        klass(description: '') do
          format
            .header('ShapeThemeStyle')
            .field(:theme, type: :symbol)
            .field(:fill_color, type: :string)
            .field(:stroke_color, type: :string)
            .field(:font_color, type: :string)
        end

        klass(description: 'Configuration container for the DrawIO DSL') do
          format
            .header('Configuration')
            .field(:base_style, type: :Struct)
            .field(:shapes, type: 'Hash&lt;Struct&gt;')
            .field(:themes, type: :Hash)
            .method('+ &lt;ConfigurationThemes&gt;')
            .method('+ &lt;ConfigurationShapes&gt;')
        end

        interface(description: 'Used to attach configuration to KConfig module', theme: :style_02) do
          format
            .header('ConfigurationExtension', interface_type: 'MixIn')
            .field(:drawio, type: :Configuration)
        end

        interface(description: 'Attach predefined DrawIO shapes to KConfig module', theme: :style_02) do
          format
            .header('ConfigurationShapes', interface_type: 'MixIn')
            .method(:add_shapes)
        end

        interface(description: 'Configuration for each theme', theme: :style_02) do
          format
            .header('ConfigurationThemes', interface_type: 'MixIn')
            .method(:add_theme)
            .method(:add_themes)
        end

        square(title: 'DOM Builder', theme: :style_01)

        klass(description: 'Build Document object model to represent DrawioDsl output file.') do
          format
            .header('DomBuilder')
            .field(:actions, type: :Array)
            .field(:last_action, type: :Hash)
            .field(:focus_node, type: :Anchor)
            .field(:current_page, type: :Page)
            .field(:dom)
            .method(:reset)
            .method(:queue_action)
            .method(:set_diagram)
            .method(:diagram)
            .method(:add_page)
            .method(:add_grid_layout)
            .method(:add_flex_layout)
            .method(:add_layout)
            .method(:add_shape)
            .method('+ &lt;DomBuilderShapes&gt;')
        end

        interface(description: 'Builder methods for each shape, line and text element to attach to DomBuilder.', theme: :style_02) do
          format
            .header('DomBuilderShapes', interface_type: 'MixIn')
            .method('add_* (for each shape)')
        end

        square(title: 'DrawIO DSL', theme: :style_01)

        klass(description: 'DSL for draw-io diagrams') do
          format
            .header('Drawio')
            .method(:diagram)
            .method(:page)
            .method(:save)
            .method(:osave)
            .method(:export_svg)
            .method(:export_png)
        end

        klass(description: 'DSL for draw-io diagrams') do
          format
            .header('DrawioPage')
            .method(:grid_layout)
            .method(:flex_layout)
            .method('+ &lt;DrawioShapes&gt;')
        end

        interface(description: 'List of DSL methods for each common shape', theme: :style_02) do
          format
            .header('DrawioShapes', interface_type: 'MixIn')
            .method(:random)
            .method('* (for each shape)')
        end

        square(title: '1000 Extension Shapes', theme: :style_01)

        klass(description: '1000s of extension shapes derived from Extensions.js that can be used via the add_shape method') do
          format
            .header('DrawioExtensions')
            .field(:sections, type: :Array)
            .field(:current_section, type: :Hash)
            .method(:section)
            .method(:shape)
            .method(:to_h)
            .method(:build_extensions)
            .method(:configure_extensions)
            .method('+ &lt;DrawioExtensionsActive&gt;')
        end

        interface(description: 'Mark shapes as active or not, based on incomplete style being made inactive', theme: :style_02) do
          format
            .header('DrawioExtensionsActive', interface_type: 'MixIn')
            .method(:apply_active_flags)
            .method(:check_if_active)
        end

        klass(description: 'Layout engine is responsible for laying out the elements on the page') do
          format
            .header('LayoutEngine')
            .field(:page, type: :Page)
            .field(:current_page, type: :Page)
            .field(:current_layout, type: :Layout)
            .method(:call)
            .method(:traverse_node)
            .method(:process_node)
        end

        klass(description: 'Build the DrawioDsl XML file that is the basis of any draw-io diagrams.') do
          format
            .header('XmlBuilder')
            .field(:diagram)
            .method(:build)
        end

        square(title: 'Formatters', theme: :style_01)

        klass(description: 'HTML builder has methods for common HTML elements that get written sequentially') do
          format
            .header('HtmlBuilder')
            .field(:element_style_defaults, type: :Hash)
            .method(:default_for)
            .method(:style_for)
            .method(:empty?)
            .method(:exist?)
            .method(:as_html)
            .method(:hr)
            .method(:b)
            .method(:p)
            .method(:add_line)
            .method(:add_placeholder)
            .method(:group)
            .method(:build_lines)
            .method(:lines)
            .method(:groups)
        end

        interface(description: 'Create an instance of a HTML formatter on the shape', theme: :style_02) do
          format
            .header('Factory', interface_type: 'MixIn')
            .method(:formatter)
            .method(:format_instance)
        end

        klass(description: 'Base for any HTML formatter') do
          format
            .header('BaseFormatter')
            .field(:html, type: :String)
            .method(:empty?)
            .method(:as_html)
        end

        klass(description: 'Format the HTML to display an interface on a class diagram') do
          format
            .header('InterfaceFormatter')
            .method(:header)
            .method(:field)
            .method(:method)
            .method(:as_html)
        end

        klass(description: 'Format the HTML to display an class on a class diagram') do
          format
            .header('KlassFormatter')
            .method(:header)
            .method(:field)
            .method(:method)
            .method(:as_html)
        end

        klass(description: 'style_builder') do
          format
            .header('StyleBuilder')
            .field(:defaults, type: :Hash)
            .field(:custom, type: :Hash)
            .method(:customize)
            .method(:style)
            .method(:style_attribute)
            .method(:build)
          end

        square(title: 'Schema', theme: :style_01)

        klass(description: 'Shape is a graphical element, it can be a shape, a text, or a group') do
          format
            .header('Shape')
            .field(:category, type: :Symbol)
            .field(:theme, type: :Symbol)
            .field(:title, type: :String)
            .field(:value, type: :String)
            .field(:white_space, type: :int)
            .field(:html, type: :int)
            .field(:rounded, type: :int)
            .field(:shadow, type: :int)
            .field(:glass, type: :int)
            .field(:sketch, type: :int)
            .field(:fill_color, type: :String)
            .field(:stroke_color, type: :String)
            .field(:font_color, type: :String)
            .field(:gradient, type: :String)
            .field(:x, type: :int)
            .field(:y, type: :int)
            .field(:w, type: :int)
            .field(:h, type: :int)
            .field(:style_modifiers, type: :Hash)
            .field(:source, type: 'Symbol (id)')
            .field(:target, type: 'Symbol (id)')
            .method('&gt; configure_shape')
            .method(:initialize)
            .method(:shape_defaults)
            .method(:apply_defaults)
            .method(:format)
            .method(:style)
            .method(:as_xml)
            .method(:draw_element)
            .method(:draw_line)
            .method(:to_h)            
          end

        klass(description: 'common_style') do
          format
            .header('CommonStyle')
            .field(:white_space, type: :int)
            .field(:html, type: :int)
            .field(:rounded, type: :int)
            .field(:shadow, type: :int)
            .field(:glass, type: :int)
            .field(:sketch, type: :int)
            .method(:to_h)
        end

        klass(description: 'default_palette') do
          format
            .header('DefaultPalette')
            .field(:fill_color, type: :String)
            .field(:stroke_color, type: :String)
            .field(:font_color, type: :String)
            .field(:gradient, type: :String)
            .method(:to_h)
        end

        klass(description: 'diagram') do
          format
            .header('Diagram')
            .field(:host, type: :String)
            .field(:theme, type: :String)
            .field(:style, type: :CommonStyle)
            .field(:palette, type: :DefaultPalette)
            .field(:pages, type: :Array)
            .method(:to_h)
        end
        klass(description: 'node') do
          format
            .header('Node')
            .field(:id, type: :String)
            .field(:page, type: :Page)
            .field(:parent, type: :Node)
            .field(:classification, type: :String)
            .field(:type, type: :String)
            .field(:nodes, type: :Array)
            .method(:initialize)
            .method(:to_h)
            .method(:root?)
            .method(:add_node)
        end

        klass(description: 'node_list') do
          format
            .header('NodeList')
            .field(:nodes, type: :Array)
            .method(:add)
            .method(:all)
            .method(:shapes)
            .method(:layouts)
            .method(:length)
            .method(:empty?)
            .method(:any?)
            .method(:first)
            .method(:as_xml)
            .method(:to_h)
        end

        klass(description: 'page') do
          format
            .header('Page')
            .field(:diagram, type: :Diagram)
            .field(:position_x, type: :int)
            .field(:position_y, type: :int)
            .field(:id, type: :String)
            .field(:active, type: :bool)
            .field(:name, type: :String)
            .field(:theme, type: :Symbol)
            .field(:style, type: :CommonStyle)
            .field(:palette, type: :DefaultPalette)
            .field(:margin_left, type: :int)
            .field(:margin_top, type: :int)
            .field(:nodes, type: :Array)
            .field(:grid, type: :String)
            .field(:grid_size, type: :int)
            .field(:guides, type: :String)
            .field(:tooltips, type: :String)
            .field(:connect, type: :String)
            .field(:arrows, type: :String)
            .field(:fold, type: :String)
            .field(:page_no, type: :String)
            .field(:page_scale, type: :String)
            .field(:page_width, type: :String)
            .field(:page_height, type: :String)
            .field(:background, type: :String)
            .field(:page_shadow, type: :String)
            .field(:math, type: :String)
            .field(:active?, type: :Boolean)
            .method(:add_node)
            .method(:as_xml)
            .method(:to_h)
            .method(:settings)
        end

        square(title: 'Schema/Layouts', theme: :style_01)

        klass(description: 'flex_layout') do
          format
            .header('FlexLayout')
            .field(:direction, type: :String)
            .field(:wrap_at, type: :int)
            .field(:gap, type: :int)
            .field(:perpendicular_max, type: :int)
            .method(:position_shape)
            .method(:to_h)
        end

        klass(description: 'grid_layout') do
          format
            .header('GridLayout')
            .field(:direction, type: :String)
            .field(:wrap_at, type: :int)
            .field(:grid_size, type: :int)
            .field(:grid_w, type: :int)
            .field(:grid_h, type: :int)
            .field(:cell_no, type: :int)
            .field(:h_align, type: :String)
            .field(:v_align, type: :String)
            .method(:position_shape)
            .method(:to_h)
        end

        klass(description: 'layout') do
          format
            .header('Layout')
            .field(:anchor_x, type: :String)
            .field(:anchor_y, type: :String)
            .method(:fire_after_init)
            .method(:after_init)
            .method(:to_h)
        end


        square(title: 'Schema/virtual', theme: :style_01)
        send(shape_element, title: 'anchor'        , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        square(title: 'Schema/shapes', theme: :style_01)

        grid_layout(wrap_at: 12, grid_w: 90, grid_h: 70)

        send(shape_element, title: 'actor'         , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'actor2'        , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'callout'       , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'callout2'      , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'callout3'      , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'callout4'      , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'circle'        , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'cloud'         , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'container'     , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'container2'    , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'container3'    , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'container4'    , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'cross'         , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'database'      , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'db_json'       , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'diamond'       , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'document'      , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'ellipse'       , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'embed_col200'  , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'embed_col50'   , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'embed_row'     , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'envelop'       , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'face'          , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'h1'            , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'h2'            , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'h3'            , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'h4'            , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'h5'            , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'h6'            , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'hexagon'       , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'interface'     , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'klass'         , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'line'          , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'note'          , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'p'             , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'process'       , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'rectangle'     , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'rectangle2'    , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'shape'         , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'square'        , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'step'          , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'tick'          , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'todo'          , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        send(shape_element, title: 'triangle'      , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)

      end
      .cd(:docs)
      .osave('domain_model.drawio')
      .save_json('domain_model')
      .export_svg('domain_model', page: 1)
  end
end

KManager.opts.app_name                    = 'domain_model'
KManager.opts.sleep                       = 2
KManager.opts.reboot_on_kill              = 0
KManager.opts.reboot_sleep                = 4
KManager.opts.exception_style             = :short
KManager.opts.show.time_taken             = true
KManager.opts.show.finished               = true
KManager.opts.show.finished_message       = 'FINISHED :)'
