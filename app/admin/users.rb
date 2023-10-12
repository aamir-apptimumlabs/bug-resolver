ActiveAdmin.register User do
  permit_params :name, :email, :approved

  member_action :toggle_approval, method: :put do
    user = User.find(params[:id])
    user.update(approved: !user.approved)
    redirect_to admin_user_path, notice: "User approval status has been updated."
  end

  index do
    column :name
    column :email
    column "Approved" do |user|
      status = user.approved? ? 'Yes' : 'No'
      span status
    end

    actions defaults: true do |user|
      if user.approved?
        link_to("Disapprove", toggle_approval_admin_user_path(user), method: :put)
      else
        link_to("Approve", toggle_approval_admin_user_path(user), method: :put)
      end
    end
  end
end
