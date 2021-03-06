KManager.action :project_plan do
  action do

    DrawioDsl::Drawio
      .init(k_builder, on_exist: :write, on_action: :execute)
      .diagram(rounded: 1, glass: 1)
      .page('In progress', theme: :style_03, margin_left: 0, margin_top: 0) do

        h5(x: 300, y: 0, w: 400, h: 80, title: 'DrawIO DSL')
        # p(x: 350, y: 40, w: 400, h: 80, title: 'Project plan - In progress')

        grid_layout(y: 90, direction: :horizontal, grid_h: 80, grid_w: 320, wrap_at: 3, grid: 0)

        todo(title: 'add miniracer to gem and test sample JS with snapshot')
        todo(title: 'add handlebarsjs file and load into snapshot')
        todo(title: 'get handlebars working with simple templates')
        todo(title: 'write a simple handlebars help in ruby')
        todo(title: 'add project plan markdown to this gem and template')
      end
      .page('To Do', theme: :style_02, margin_left: 0, margin_top: 0) do

        # h5(x: 300, y: 0, w: 400, h: 80, title: 'DrawIO DSL')
        # p(x: 350, y: 40, w: 400, h: 80, title: 'Project plan')

        grid_layout(y:90, direction: :horizontal, grid_h: 80, grid_w: 320, wrap_at: 3, grid: 0)

      end
      .page('Done', theme: :style_06, margin_left: 0, margin_top: 0) do

        # h5(x: 300, y: 0, w: 400, h: 80, title: 'DrawIO DSL')
        # p(x: 350, y: 40, w: 400, h: 80, title: 'Done')

        grid_layout(y:90, direction: :horizontal, grid_h: 80, grid_w: 320, wrap_at: 3, grid: 0)

      end
      .cd(:docs)
      .save('project-plan/project.drawio')
      .export_svg('project-plan/project_in_progress', page: 1)
      .export_svg('project-plan/project_todo'       , page: 2)
      .export_svg('project-plan/project_done'       , page: 3)
  end
end
