KManager.action :domain_model do
  action do

    DrawioDsl::Drawio
      .init(k_builder, on_exist: :write, on_action: :execute)
      .diagram(theme: :style_04)
      .page('Domain Modal', margin_left: 0, margin_top: 0, rounded: 0, background: '#fafafa') do
        group_element = {
          theme: :style_01, w: 50, h: 50
        }

        blank = {
          fill_color: '#fafafa',
          stroke_color: '#fafafa',
          font_color: '#fafafa',
          w: 10,
          h: 10
        }

        box_width = 160

        ################################################################################
        # Domain Model
        ################################################################################

        grid_layout(wrap_at: 6, grid_w: box_width+20, grid_h: box_width+20)

        klass(theme: :style_02) do
          format
            .header('Flow')
            .field('attach handlebars-4.7.7.js')
            .field('attach handlebars-custom.js')
        end


        klass() do
          format
            .header('Configuration')
            .field(:javascript)
            .field(:javascript_file)
        end

        klass() do
          format
            .header('Manager')
            .field(:snapshot    , type: 'MR::Snapshot')
            .method(:load_javascript)
            .method(:register_helper)     # support javascript or ruby
            .method(:register_partial)
            .method(:compile_template)    # compiles a template and then returns it as a memory object to 
            .method(:execute_template)    # 
            .method(:execute_javascript)

        end

        klass() do
          format
            .header('Context')
        end

        2.times { square(**blank) }

        ################################################################################
        # Gem Architecture
        ################################################################################

        box_width = 80

        grid_layout(wrap_at: 6, grid_w: box_width+20, grid_h: box_width+20)

        original = {
          theme: :style_04, w: box_width, h: box_width
        }
        new_gems = {
          theme: :style_03, w: box_width, h: box_width
        }
        old_gems = {
          theme: :style_06, w: box_width, h: box_width
        }
        v8_engine = {
          theme: :style_10, w: box_width, h: box_width
        }

        square(:a1, **original  , title: 'KManager -> KBuilder')
        square(:a2, **original  , title: 'Handlebars-Helpers (ruby)')
        square(:a3, **new_gems  , title: 'HandlebarsJS (ruby)')
        square(:a4, **new_gems  , title: 'Mini Racer')
        square(:a5, **old_gems  , title: 'Handlebars (ruby)')
        square(:a6, **old_gems  , title: 'The Ruby Racer')

        square(:a7, **v8_engine , title: 'Node V8 engine')
        square(:a8, **original  , title: 'Handlebars.js (javascript)')
        
        solid(source: :a1, target: :a2, exit_point: :e, entry_point: :w, waypoint: :orthogonal_curved)
        solid(source: :a2, target: :a3, exit_point: :e, entry_point: :w, waypoint: :orthogonal_curved)
        solid(source: :a3, target: :a4, exit_point: :e, entry_point: :w, waypoint: :orthogonal_curved)
        solid(source: :a2, target: :a5, exit_point: :e, entry_point: :w, waypoint: :orthogonal_curved)
        solid(source: :a5, target: :a6, exit_point: :e, entry_point: :w, waypoint: :orthogonal_curved)

        solid(source: :a4, target: :a7, exit_point: :e, entry_point: :w, waypoint: :orthogonal_curved)
        solid(source: :a6, target: :a7, exit_point: :e, entry_point: :w, waypoint: :orthogonal_curved)

        solid(source: :a7, target: :a8, exit_point: :e, entry_point: :w, waypoint: :orthogonal_curved)

        4.times { square(**blank) }

        grid_layout(wrap_at: 1, grid_w: box_width+20, grid_h: box_width+20)
        group(title: 'Domain Model', **group_element)
        group(title: 'GEM Architecture Flow', **group_element)

        # grid_layout(wrap_at: 12, grid_w: 90, grid_h: 70)

        # shape_element = :rectangle2 # hexagon, diamond, ellipse
        # shape_element_w = 75
        # shape_element_h = 50
        # shape_element_theme = :style_03

        # send(shape_element, title: 'actor'         , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'actor2'        , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'callout'       , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'callout2'      , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'callout3'      , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'callout4'      , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'circle'        , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'cloud'         , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'container'     , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'container2'    , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'container3'    , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'container4'    , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'cross'         , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'database'      , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'db_json'       , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'diamond'       , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'document'      , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'ellipse'       , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'embed_col200'  , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'embed_col50'   , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'embed_row'     , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'envelop'       , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'face'          , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'h1'            , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'h2'            , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'h3'            , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'h4'            , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'h5'            , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'h6'            , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'hexagon'       , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'interface'     , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'klass'         , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'line'          , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'note'          , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'p'             , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'process'       , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'rectangle'     , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'rectangle2'    , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'shape'         , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'square'        , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'step'          , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'tick'          , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'todo'          , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)
        # send(shape_element, title: 'triangle'      , w: shape_element_w, h: shape_element_h, theme: shape_element_theme)

      end
      .cd(:docs)
      .save('domain_model.drawio')
      .save_json('domain_model')
      # .export_svg('domain_model', page: 1)
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
