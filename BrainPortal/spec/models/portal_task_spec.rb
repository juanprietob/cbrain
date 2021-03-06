
#
# CBRAIN Project
#
# Copyright (C) 2008-2012
# The Royal Institution for the Advancement of Learning
# McGill University
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

require 'rails_helper'

describe PortalTask do

  let(:portal_task) { create("cbrain_task/diagnostics") }

  describe "#add_new_params_defaults" do

    it "should add default params to the params hash" do
      default_args = {:default_key => :default_value}
      given_params = {:key => :value}
      allow(portal_task.class).to receive(:default_launch_args).and_return(default_args)
      portal_task.params = given_params
      portal_task.add_new_params_defaults
      expect(portal_task.params).to eq(default_args.merge(given_params))
    end

    it "should not crush given param values" do
      default_args     = {:key => :default_value}
      collision_params = {:key => :given_value}
      allow(portal_task.class).to receive(:default_launch_args).and_return(default_args)
      portal_task.params = collision_params
      portal_task.add_new_params_defaults
      expect(portal_task.params).to eq(collision_params)
    end
  end

  describe "#properties" do

    it "should return the properties hash" do
      expect(PortalTask.properties).to be_a Hash
    end

  end

  describe "#default_launch_args" do

    it "should return an empty hash" do
      expect(PortalTask.default_launch_args).to eq({})
    end

  end

  describe "#pretty_params_names" do

    it "should return an empty hash"do
      expect(PortalTask.pretty_params_names).to eq({})
    end

  end

  describe "#before_form" do

    it "should return an empty string" do
      expect(portal_task.before_form).to eq("")
    end

  end

  describe "#after_form" do
    it "should return an empty string" do
      expect(portal_task.after_form).to eq("")
    end

  end

  describe "#after_final_task_list_saved" do

    it "should return an empty string" do
      expect(portal_task.after_final_task_list_saved([portal_task])).to eq("")
    end

  end

  describe "#unpresetable_params_attributes" do

    it "should return an empty hash" do
      expect(portal_task.unpresetable_params_attributes).to eq({})
    end

  end

  describe "#wrapper_default_launch_args" do

    it "should call default_launch_args" do
      expect(PortalTask).to receive(:default_launch_args).and_return({})
      PortalTask.wrapper_default_launch_args
    end

    it "should raise an error if default args is not a hash" do
      allow(PortalTask).to receive(:default_launch_args).and_return(nil)
      expect { PortalTask.wrapper_default_launch_args }.to raise_error(ScriptError)
    end

    it "should reraise CbrainErrors" do
      allow(PortalTask).to receive(:default_launch_args).and_raise(CbrainError)
      expect { PortalTask.wrapper_default_launch_args }.to raise_error(CbrainError)
    end

    it "should reraise CbrainNotices" do
      allow(PortalTask).to receive(:default_launch_args).and_raise(CbrainNotice)
      expect { PortalTask.wrapper_default_launch_args }.to raise_error(CbrainNotice)
    end

    it "should convert other errors to ScriptErrors" do
      allow(PortalTask).to receive(:default_launch_args).and_raise(StandardError)
      expect { PortalTask.wrapper_default_launch_args }.to raise_error(ScriptError)
    end

  end

  describe "#wrapper_before_form" do

    it "should call before_form" do
      expect(portal_task).to receive(:before_form).and_return("")
      portal_task.wrapper_before_form
    end

    it "should raise an error if default args is not a string" do
      allow(portal_task).to receive(:before_form).and_return(nil)
      expect { portal_task.wrapper_before_form }.to raise_error(ScriptError)
    end

    it "should raise an error if refresh_form saves the object" do
      allow(portal_task).to receive(:new_record?).and_return(true, false)
      expect { portal_task.wrapper_before_form }.to raise_error(ScriptError)
    end

    it "should reraise CbrainErrors" do
      allow(portal_task).to receive(:before_form).and_raise(CbrainError)
      expect { portal_task.wrapper_before_form }.to raise_error(CbrainError)
    end

    it "should reraise CbrainNotices" do
      allow(portal_task).to receive(:before_form).and_raise(CbrainNotice)
      expect { portal_task.wrapper_before_form }.to raise_error(CbrainNotice)
    end

    it "should convert other errors to ScriptErrors" do
      allow(portal_task).to receive(:before_form).and_raise(StandardError)
      expect { portal_task.wrapper_before_form }.to raise_error(ScriptError)
    end

  end

  describe "#wrapper_refresh_form" do

    it "should call refresh_form" do
      expect(portal_task).to receive(:refresh_form).and_return("")
      portal_task.wrapper_refresh_form
    end

    it "should raise an error if refresh_form return value is not a string" do
      expect(portal_task).to receive(:refresh_form).and_return(nil)
      expect { portal_task.wrapper_refresh_form }.to raise_error(ScriptError)
    end

    it "should raise an error if refresh_form saves the object" do
      allow(portal_task).to receive(:new_record?).and_return(true, false)
      expect { portal_task.wrapper_refresh_form }.to raise_error(ScriptError)
    end

    it "should register CbrainErrors as errors on the object" do
      allow(portal_task).to receive(:refresh_form).and_raise(CbrainError)
      portal_task.wrapper_refresh_form
      expect(portal_task.errors).to include(:base)
    end

    it "should register CbrainNotices as errors on the object" do
      allow(portal_task).to receive(:refresh_form).and_raise(CbrainNotice)
      portal_task.wrapper_refresh_form
      expect(portal_task.errors).to include(:base)
    end

    it "should convert other errors to ScriptErrors" do
      expect(portal_task).to receive(:refresh_form).and_raise(StandardError)
      expect { portal_task.wrapper_refresh_form }.to raise_error(ScriptError)
    end

  end

  describe "#wrapper_after_form" do

    it "should call after_form" do
      expect(portal_task).to receive(:after_form).and_return("")
      portal_task.wrapper_after_form
    end

    it "should raise an error if default args is not a string" do
      allow(portal_task).to receive(:after_form).and_return(nil)
      expect { portal_task.wrapper_after_form }.to raise_error(ScriptError)
    end

    it "should raise an error if after_form saves the object and property not set to allow saving" do
      allow(portal_task.class).to receive(:properties).and_return(:i_save_my_task_in_after_form => false)
      allow(portal_task).to receive(:new_record?).and_return(true, false)
      expect { portal_task.wrapper_after_form }.to raise_error(ScriptError)
    end

    it "should not raise an error if after_form saves the object and property set to allow saving" do
      allow(portal_task.class).to receive(:properties).and_return(:i_save_my_task_in_after_form => true)
      allow(portal_task).to receive(:new_record?).and_return(true, false)
      expect { portal_task.wrapper_after_form }.not_to raise_error
    end

    it "should reraise CbrainErrors" do
      allow(portal_task).to receive(:after_form).and_raise(CbrainError)
      expect { portal_task.wrapper_after_form }.to raise_error(CbrainError)
    end

    it "should reraise CbrainNotices" do
      allow(portal_task).to receive(:after_form).and_raise(CbrainNotice)
      expect { portal_task.wrapper_after_form }.to raise_error(CbrainNotice)
    end

    it "should convert other errors to ScriptErrors" do
      allow(portal_task).to receive(:after_form).and_raise(StandardError)
      expect { portal_task.wrapper_after_form }.to raise_error(ScriptError)
    end

  end

  describe "#wrapper_final_task_list" do
    before(:each) do
      allow(portal_task).to receive(:new_record?).and_return(true)
    end

    it "should call final_task_list" do
      expect(portal_task).to receive(:final_task_list).and_return([portal_task])
      portal_task.wrapper_final_task_list
    end

    it "should raise an error if final_task_list does not return an array" do
      allow(portal_task).to receive(:final_task_list).and_return(nil)
      expect { portal_task.wrapper_final_task_list }.to raise_error(ScriptError)
    end

    it "should raise an error if final_task_list returns an array that doesn't contain CbrainTasks" do
      allow(portal_task).to receive(:final_task_list).and_return([nil])
      expect { portal_task.wrapper_final_task_list }.to raise_error(ScriptError)
    end

    it "should raise an error if final_task_list saves objects and property not set to allow saving" do
      allow(portal_task.class).to receive(:properties).and_return(:i_save_my_tasks_in_final_task_list => false)
      allow(portal_task).to receive(:new_record?).and_return(false)
      expect { portal_task.wrapper_final_task_list }.to raise_error(ScriptError)
    end

    it "should reraise CbrainErrors" do
      allow(portal_task).to receive(:final_task_list).and_raise(CbrainError)
      expect { portal_task.wrapper_final_task_list }.to raise_error(CbrainError)
    end

    it "should reraise CbrainNotices" do
      allow(portal_task).to receive(:final_task_list).and_raise(CbrainNotice)
      expect { portal_task.wrapper_final_task_list }.to raise_error(CbrainNotice)
    end

    it "should convert other errors to ScriptErrors" do
      allow(portal_task).to receive(:final_task_list).and_raise(StandardError)
      expect { portal_task.wrapper_final_task_list }.to raise_error(ScriptError)
    end

  end

  describe "#wrapper_after_final_task_list_saved" do

    it "should call after_final_task_list_saved" do
      expect(portal_task).to receive(:after_final_task_list_saved).and_return("")
      portal_task.wrapper_after_final_task_list_saved([portal_task])
    end

    it "should raise an error if after_final_task_list_saved does not return a string" do
      expect(portal_task).to receive(:after_final_task_list_saved).and_return(nil)
      expect { portal_task.wrapper_after_final_task_list_saved([portal_task]) }.to raise_error(ScriptError)
    end

    it "should reraise CbrainErrors" do
      allow(portal_task).to receive(:after_final_task_list_saved).and_raise(CbrainError)
      expect { portal_task.wrapper_after_final_task_list_saved([portal_task]) }.to raise_error(CbrainError)
    end

    it "should reraise CbrainNotices" do
      allow(portal_task).to receive(:after_final_task_list_saved).and_raise(CbrainNotice)
      expect { portal_task.wrapper_after_final_task_list_saved([portal_task]) }.to raise_error(CbrainNotice)
    end

    it "should convert other errors to ScriptErrors" do
      allow(portal_task).to receive(:after_final_task_list_saved).and_raise(StandardError)
      expect { portal_task.wrapper_after_final_task_list_saved([portal_task]) }.to raise_error(ScriptError)
    end

  end

  describe "#wrapper_untouchable_params_attributes" do

    it "should call untouchable_params_attributes" do
      expect(portal_task).to receive(:untouchable_params_attributes).and_return(nil)
      portal_task.wrapper_untouchable_params_attributes
    end

    it "should add :interface_userfile_ids to the untouchable params hash" do
      allow(portal_task).to receive(:untouchable_params_attributes).and_return({})
      expect(portal_task.wrapper_untouchable_params_attributes).to include(:interface_userfile_ids)
    end

  end

  describe "#wrapper_unpresetable_params_attributes" do

    it "should call unpresetable_params_attributes" do
      expect(portal_task).to receive(:unpresetable_params_attributes).and_return(nil)
      portal_task.wrapper_unpresetable_params_attributes
    end

    it "should default to an empty hash" do
      allow(portal_task).to receive(:unpresetable_params_attributes).and_return(nil)
      expect(portal_task.wrapper_unpresetable_params_attributes).to eq({})
    end

    it "should return the value returned by unpresetable_params_attributes" do
      return_value = {:key => :value}
      allow(portal_task).to receive(:unpresetable_params_attributes).and_return(return_value)
      expect(portal_task.wrapper_unpresetable_params_attributes).to eq(return_value)
    end

  end

  describe "#params_errors" do
    let(:param_errors) { double("param_errors").as_null_object }

    it "should create a new ParamsErrors object" do
      expect(PortalTask::ParamsErrors).to receive(:new).and_return(param_errors)
      portal_task.params_errors
    end

    it "should set the real_errors attribute on the params_errors" do
      allow(PortalTask::ParamsErrors).to receive(:new).and_return(param_errors)
      expect(param_errors).to receive(:real_errors=)
      portal_task.params_errors
    end

  end

  describe "#human_attribute_name" do

    it "should remove the cbrain_tasks_param part from the string if it's there'" do
      expect(PortalTask.human_attribute_name("cbrain_task_params_xyz")).to eq("xyz")
    end

    it "should use the pretty names hash if it applies" do
      allow(PortalTask).to receive(:pretty_params_names).and_return("cbrain_task_params_xyz" => "pretty")
      expect(PortalTask.human_attribute_name("cbrain_task_params_xyz")).to eq("pretty")
    end

    it "should convert the pretty names sub hash keys if they haven't already beed" do
      allow(PortalTask).to receive(:pretty_params_names).and_return("xyz[abc]" => "pretty")
      expect(PortalTask.human_attribute_name("cbrain_task_params_xyz_abc")).to eq("pretty")
    end

    it "should return the humanized version of the string if cbrain_tasks part isn't there" do
      expect(PortalTask.human_attribute_name("my_xyz")).to eq("my_xyz".humanize)
    end

  end

  describe "#restore_untouchable_attributes" do
    let(:old_values) { {untouchable_param:1, unpresetable_param:2, touchable_param:3, presetable_param:4} }
    let(:new_values) { {untouchable_param:5, unpresetable_param:6, touchable_param:7, presetable_param:8} }

    before(:each) do
      allow(portal_task).to receive(:wrapper_untouchable_params_attributes).and_return(:untouchable_param => true)
      allow(portal_task).to receive(:wrapper_unpresetable_params_attributes).and_return(:unpresetable_param => true)
      portal_task.params = new_values
    end

    it "should set any params to old values if they are in the untouchable hash" do
      portal_task.restore_untouchable_attributes(old_values)
      expect(portal_task.params[:untouchable_param]).to eq(old_values[:untouchable_param])
    end

    it "should not set any params to old values if they are not in the untouchable hash" do
      portal_task.restore_untouchable_attributes(old_values)
      expect(portal_task.params[:touchable_param]).to eq(new_values[:touchable_param])
    end

    it "should set any params to old values if they are in the unpresetable hash and the option is set" do
      portal_task.restore_untouchable_attributes(old_values, :include_unpresetable => true)
      expect(portal_task.params[:unpresetable_param]).to eq(old_values[:unpresetable_param])
    end

    it "should not set any params to old values if they are not in the unpresetable hash" do
      portal_task.restore_untouchable_attributes(old_values, :include_unpresetable => true)
      expect(portal_task.params[:presetable_param]).to eq(new_values[:presetable_param])
    end

    it "should not set any params to old values if they are in the unpresetable hash but the option is not set" do
      portal_task.restore_untouchable_attributes(old_values)
      expect(portal_task.params[:unpresetable_param]).to eq(new_values[:unpresetable_param])
    end

  end

  describe "::ParamsErrors" do
    let(:params_errors) { PortalTask::ParamsErrors.new }
    let(:real_errors)   { double("real_errors").as_null_object }
    let(:param_path)    { "param_path" }

    before(:each) do
      params_errors.real_errors = real_errors
    end

    describe "#on" do

      it "should convert the path argument to la and forward it" do
        expect(real_errors).to receive(:on).with(param_path.to_la_id)
        params_errors.on(param_path)
      end

    end

    describe "#[]" do

      it "should convert the path argument to la and forward an #on call" do
        expect(real_errors).to receive(:on).with(param_path.to_la_id)
        params_errors[param_path]
      end

    end

    describe "#add" do

      it "should convert the path argument to la and forward it" do
        expect(real_errors).to receive(:add).with(param_path.to_la_id)
        params_errors.add(param_path)
      end

    end

    describe "#add_on_blank" do

      it "should convert the path arguments to la and forward it" do
        expect(real_errors).to receive(:add_on_blank).with([param_path.to_la_id])
        params_errors.add_on_blank([param_path])
      end

    end

    describe "#add_on_empty" do

      it "should convert the path argument to la and forward it" do
        expect(real_errors).to receive(:add_on_empty).with([param_path.to_la_id])
        params_errors.add_on_empty([param_path])
      end

    end

    describe "#add_to_base" do

      it "should convert the path argument to la and forward it" do
        expect(real_errors).to receive(:add_to_base)
        params_errors.add_to_base
      end

    end

    describe "#size" do

      it "should forward the call" do
        expect(real_errors).to receive(:size)
        params_errors.size
      end

    end

    describe "#count" do

      it "should forward a #size call" do
        expect(real_errors).to receive(:size)
        params_errors.count
      end

    end

    describe "#length" do

      it "should forward a #size call" do
        expect(real_errors).to receive(:size)
        params_errors.length
      end

    end

    describe "#clear" do

      it "should forward the call" do
        expect(real_errors).to receive(:clear)
        params_errors.clear
      end

    end

    describe "#each" do

      it "should forward the call" do
        expect(real_errors).to receive(:each)
        params_errors.each
      end

    end

    describe "#each_full" do

      it "should forward the call" do
        expect(real_errors).to receive(:each_full)
        params_errors.each_full
      end

    end

    describe "#empty?" do

      it "should forward the call" do
        expect(real_errors).to receive(:empty?)
        params_errors.empty?
      end

    end

    describe "#full_messages" do

      it "should forward the call" do
        expect(real_errors).to receive(:full_messages)
        params_errors.full_messages
      end

    end

    describe "#generate_message" do

      it "should convert the path argument to la and forward it" do
        expect(real_errors).to receive(:generate_message).with(param_path.to_la_id)
        params_errors.generate_message(param_path)
      end

    end

    describe "#invalid?" do

      it "should convert the path argument to la and forward it" do
        expect(real_errors).to receive(:invalid?).with(param_path.to_la_id)
        params_errors.invalid?(param_path)
      end

    end
    describe "#on_base" do

      it "should forward the call" do
        expect(real_errors).to receive(:on_base)
        params_errors.on_base
      end

    end

    describe "#to_xml" do

      it "should forward the call" do
        expect(real_errors).to receive(:on_base)
        params_errors.on_base
      end

    end

  end

end

