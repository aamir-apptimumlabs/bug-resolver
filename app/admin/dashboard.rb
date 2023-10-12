# app/admin/dashboard.rb
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    columns do
      column do
        panel "Recent Users" do
          ul do
            User.all.each do |user|
              li do
                # span link_to(user.name, user_registration_path(user))
                strong user.name
                span "Approved: #{user.approved? ? 'Yes' : 'No'}".html_safe
                if user.approved?
                  span link_to("Disapprove", toggle_approval_admin_user_path(user), method: :put)
                else
                  span link_to("Approve", toggle_approval_admin_user_path(user), method: :put)
                end                
              end
            end
          end
        end
      end
    end
  end

  # Define the toggle_approval action using page_action
  page_action :toggle_approval, method: :put do
    user = User.find(params[:id])
    user.update(approved: !user.approved)
    redirect_to admin_dashboard_path, notice: "User approval status has been updated."
  end
end
