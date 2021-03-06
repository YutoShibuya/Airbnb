# frozen_string_literal: true

require File.expand_path("../../test_helper", __FILE__)

module Stripe
  class SubscriptionTest < Test::Unit::TestCase
    should "be listable" do
      subscriptions = Stripe::Subscription.list
      assert_requested :get, "#{Stripe.api_base}/v1/subscriptions"
      assert subscriptions.data.is_a?(Array)
      assert subscriptions.data[0].is_a?(Stripe::Subscription)
    end

    should "be retrievable" do
      subscription = Stripe::Subscription.retrieve("sub_123")
      assert_requested :get,
                       "#{Stripe.api_base}/v1/subscriptions/sub_123"
      assert subscription.is_a?(Stripe::Subscription)
    end

    should "be creatable" do
      subscription = Stripe::Subscription.create(
        customer: "cus_123"
      )
      assert_requested :post, "#{Stripe.api_base}/v1/subscriptions"
      assert subscription.is_a?(Stripe::Subscription)
    end

    should "be saveable" do
      subscription = Stripe::Subscription.retrieve("sub_123")
      subscription.metadata["key"] = "value"
      subscription.save
      assert_requested :post,
                       "#{Stripe.api_base}/v1/subscriptions/#{subscription.id}"
    end

    should "be updateable" do
      subscription = Stripe::Subscription.update("sub_123", metadata: { foo: "bar" })
      assert_requested :post,
                       "#{Stripe.api_base}/v1/subscriptions/sub_123"
      assert subscription.is_a?(Stripe::Subscription)
    end

    should "be deletable" do
      subscription = Stripe::Subscription.retrieve("sub_123")
      subscription = subscription.delete
      assert_requested :delete,
                       "#{Stripe.api_base}/v1/subscriptions/#{subscription.id}"
      assert subscription.is_a?(Stripe::Subscription)
    end

    context "#delete_discount" do
      should "be able to delete a subscriptions's discount" do
        subscription = Stripe::Subscription.retrieve("sub_123")
        subscription = subscription.delete_discount
        assert subscription.is_a?(Stripe::Subscription)
      end
    end

    context "#serialize_params" do
      should "serialize when items is set to an Array" do
        obj = Stripe::Util.convert_to_stripe_object({
          object: "subscription",
          items: Stripe::Util.convert_to_stripe_object(
            object: "list",
            data: []
          ),
        }, {})
        obj.items = [
          { id: "si_foo", deleted: true },
          { plan: "plan_bar" },
        ]

        expected = {
          items: {
            :"0" => { id: "si_foo", deleted: true },
            :"1" => { plan: "plan_bar" },
          },
        }
        assert_equal(expected, obj.serialize_params)
      end

      should "serialize when items is set to a Hash" do
        obj = Stripe::Util.convert_to_stripe_object({
          object: "subscription",
          items: Stripe::Util.convert_to_stripe_object(
            object: "list",
            data: []
          ),
        }, {})
        obj.items = {
          "0" => { id: "si_foo", deleted: true },
          "1" => { plan: "plan_bar" },
        }

        expected = {
          items: {
            :"0" => { id: "si_foo", deleted: true },
            :"1" => { plan: "plan_bar" },
          },
        }
        assert_equal(expected, obj.serialize_params)
      end
    end
  end
end
