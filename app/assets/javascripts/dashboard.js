(function ($) {
  var stateTemplate,
      barTemplate,
      timeGraph,
      stateGraphs,
      projectId;

  function init() {
    stateTemplate = $('#state-graph-template');
    barTemplate = $('#bar-graph-template');
    timeGraph = $('.time-graph');
    stateGraphs = $('.state-graphs');
    projectId = getProjectId();

    if (projectId) {
      setInterval(pullData, (1000 * 60 * 60 * 4));
      pullData();
    }
    else {
      renderNotFound();
    }
  }

  function render(data) {
    renderBar(data);
    renderStateGraphs(data);
  }

  function renderBar(data) {
    var barGraph = generateBarGraph(data.charts.trends[0]);

    timeGraph.html('');
    timeGraph.append(barGraph);
  }

  function renderStateGraphs(data) {
    var states = data.charts.gauges.map(function (gauge) {
      return generateStateGraph(gauge);
    });

    stateGraphs.html('');
    stateGraphs.append(states.join(''));
  }

  function generateStateGraph(graphData) {
    var stateGraph = $(stateTemplate.html()),
        trend = stateGraph.find('.state-graph__trend');

    stateGraph.find('.state-graph__name').text(graphData.name);
    stateGraph.find('.state-graph__value').text(graphData.value);
    trend.text(graphData.diff + "%");
    if (graphData.diff === 0) {
      trend.addClass('state-graph__trend--zero');
    }
    else if (graphData.positive) {
      trend.addClass('state-graph__trend--up');
    }
    else {
      trend.addClass('state-graph__trend--down');
    }

    return stateGraph[0].outerHTML;
  }

  function generateBarGraph(graphData) {
    var barGraph = $(barTemplate.html()),
        wrapper,
        bars;

    bars = graphData.data.map(function (bar) {
      return getBarElement(bar);
    });

    wrapper = barGraph.find('.bar-graph__wrapper');
    wrapper.html('');
    wrapper.append(bars.join(''));
    barGraph.find('.bar-graph__y-label').text(graphData.label.y);
    barGraph.find('.bar-graph__x-label').text(graphData.label.x);

    return barGraph[0].outerHTML;
  }

  function getBarElement(bar) {
    var barElement = $('<div />');

    barElement.addClass('bar-graph__bar');
    barElement.css({
      height: bar + '%',
      'background-color': getColor(bar)
    });
    barElement.text(bar + '%');

    return barElement[0].outerHTML;
  }

  function getColor(value) {
     var red = 252 - value,
         blue = 11 + value,
         green = 92 + value;

    return 'rgb('+red+','+green+','+blue+')';
  }

  function parseQueryString() {
    var queryString = window.location.search,
        queryObject = {},
        entery;

    if (queryString) {
      queryString.substr(1).split('&').forEach(function (pair) {
        entery = pair.split('=', 2);
        queryObject[entery[0]] = entery[1];
      });
    }

    return queryObject;
  }

  function getProjectId() {
    var query = parseQueryString();
    return query.project;
  }

  function pullData() {
    $.ajax ({
      url: '/api/metrics/' + projectId,
      method: 'GET',
      success: function (result) {
        render(result);
      }
    })
  }

  function renderNotFound() {
    $('.graphs').html($('#not-found-template').html());
  }

  $(init);
}(jQuery));