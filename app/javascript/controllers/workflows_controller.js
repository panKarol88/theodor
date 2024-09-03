import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  featureSelect(event) {
    const workflowId = event.currentTarget.dataset.workflowId;
    const featureId = event.target.value;

    let frame = document.getElementById("new_feature_workflow");
    frame.src = `/workflows/${workflowId}/features/${featureId}`;
  }
}
