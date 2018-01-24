<!-- © Nate Kim 2018 -->
<chart>

  <div class="chart"></div>

  <script>
  this.size = 250;
  this.margin = {
    top: 20,
    right: 20,
    bottom: 30,
    left: 40
  };
  this.width = this.size - this.margin.left - this.margin.right;
  this.height = this.size - this.margin.top - this.margin.bottom;

  this.x_scale = d3.scale.linear()
    .domain([0, 100])
    .range([0, this.width]);

  this.y_scale = d3.scale.linear()
    .domain([0, 100])
    .range([this.height, 0]);

  this.colors = {
    available: '#129fea',
    saved: '#bd4b1e',
    filtered: '#6f6f6f',
  };

  this.xAxis = d3.svg.axis()
    .scale(this.x_scale)
    .ticks(5)
    .orient("bottom");

  this.yAxis = d3.svg.axis()
    .scale(this.y_scale)
    .ticks(5)
    .orient("left");

  this.drag = d3.behavior.drag();
  this.drag.on('drag', function() {
    app.ctrl.setIssuesMin(this.y_scale.invert(d3.event.y));
    app.ctrl.setPRMin(this.x_scale.invert(d3.event.x));
  }.bind(this));

  this.on('mount', function() {

    this.svg = d3.select(".chart").append("svg")
      .attr("width", this.width + this.margin.left + this.margin.right)
      .attr("height", this.height + this.margin.top + this.margin.bottom)
      .append("g")
      .attr("transform", "translate(" + this.margin.left + "," + this.margin.top + ")");

    this.crit_thresh = this.svg.append('line')
      .attr('class', 'threshold')
      .attr("x2", this.x_scale(100));

    this.aud_thresh = this.svg.append('line')
      .attr('class', 'threshold')
      .attr("y2", this.y_scale(100));

    this.svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + this.height + ")")
      .call(this.xAxis)
      .append("text")
      .attr("class", "label")
      .attr("x", this.width)
      .attr("y", -6)
      .style("text-anchor", "end")
      .text("PR");

    this.svg.append("g")
      .attr("class", "y axis")
      .call(this.yAxis)
      .append("text")
      .attr("class", "label")
      .attr("transform", "rotate(-90)")
      .attr("y", 6)
      .attr("dy", ".71em")
      .style("text-anchor", "end")
      .text("Issues");

    this.svg.selectAll(".dot")
      .data(app.coins)
      .enter().append("circle")
      .attr("class", "dot")
      .attr("cx", function(coin) {
        return this.x_scale(coin.pr_score);
      }.bind(this))
      .attr("cy", function(coin) {
        return this.y_scale(coin.issues_score);
      }.bind(this));

    this.handle = this.svg.append("circle")
      .attr("class", "handle")
      .attr("r", 6.5);

    this.handle.call(this.drag);

    this.updateChart();
  }.bind(this));

  this.updateChart = function() {
    this.svg.selectAll(".dot")
      .data(app.coins)
      .attr("r", function(coin) {
        return app.isSaved(coin.id) ? 3 : 2;
      }.bind(this))
      .style("fill", function(coin) {
        if (app.isAvailable(coin.id)) {
          return this.colors.available;
        } else if (app.isSaved(coin.id)) {
          return this.colors.saved;
        }
        return this.colors.filtered;
      }.bind(this));

    var issues_min_pos = this.y_scale(app.issues_min),
      pr_min_pos = this.x_scale(app.pr_min);

    this.issues_thresh
      .attr("x1", pr_min_pos)
      .attr("y1", issues_min_pos)
      .attr("y2", issues_min_pos);

    this.pr_thresh
      .attr("y1", issues_min_pos)
      .attr("x1", pr_min_pos)
      .attr("x2", pr_min_pos);

    this.handle
      .attr("cx", pr_min_pos)
      .attr("cy", issues_min_pos);
  }.bind(this);

  app.on('update', this.updateChart);

  </script>


  <style scoped>
  :scope {
    display: block;
    margin-top: 20px;
  }

  .chart {
    position: relative;
    left: -10px;
  }

  .threshold {
    fill: none;
    stroke: #6f6f6f;
    shape-rendering: crispEdges;
  }

  .axis path,
  .axis line {
    fill: none;
    stroke: #000000;
    shape-rendering: crispEdges;
  }

  .dot {
    stroke: none;
  }

  .handle {
    fill: #e8e8e8;
    stroke: #949494;
    stroke-width: 1;
  }

  </style>

</chart>
