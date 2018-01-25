<ratings>

  <div>
    <label for="issues">Issues 점수</label>
    <div class="range-group">
      <input type="range" name="issues_score" min="0" max="100" step="1" value="{ app.issues_min }" oninput={ updateIssuesMin }>
      <div class="value">{ app.issues_min }</div>
    </div>
  </div>
  <div>
    <label for="pr">PR 점수</label>
    <div class="range-group">
      <input type="range" name="pr_score" min="0" max="100" step="1" value="{ app.audience_min }" oninput={ updatePRMin }>
      <div class="value">{ app.pr_min }</div>
    </div>
  </div>

  <script>

  updateIssuesMin() {
    app.ctrl.setIssuesMin(this.issues.value);
  }

  updatePRMin() {
    app.ctrl.setPRMin(this.pr.value);
  }


  </script>


  <style scoped>
  :scope {
    display: block;
  }

  .range-group {
    display: flex;
  }

  input {
    width: 100%;
  }

  .value {
    display: inline-block;
    margin-left: 1em;
    width: 3em;
  }

  </style>

</ratings>
