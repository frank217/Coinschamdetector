<availablecoin class="{ hidden: !app.isAvailable(id) }">

  <thumbnail class="clickable" onclick="{ select }"></thumbnail>
  <div class="info">
    <div class="clickable" onclick="{ select }">
      <div class="coin_name">{ coin_name }</div>
    </div>
    <br>
    <div>
      <div>{ issues_score } - Issues</div>
      <div>{ pr_score } - PR</div>
    </div>

    <div class="buttons">
      <div class="clickable" onclick="{ nope }">✖</div>
      <div class="clickable" onclick="{ yep }">✔</div>
    </div>
  </div>


  <script>
  yep() {
    app.ctrl.save(this.id);
  }

  nope() {
    app.ctrl.shelve(this.id);
  }

  select() {
    app.ctrl.select(this.id);
  }

  </script>


  <style scoped>
  :scope {
    display: flex;
    margin-bottom: 10px;
  }

  .coin_name {
    font-weight: bold;
  }

  .info {
    margin-left: 10px;
  }

  </style>

</availablecoin>
