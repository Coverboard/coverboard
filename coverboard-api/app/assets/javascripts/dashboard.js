(function($){
  var stateTemplate,
      barTemplate,
      timeGraph,
      stateGraphs;

  function init(){
    stateTemplate = $('#state-graph-template');
    barTemplate = $('#bar-graph-template');
    timeGraph = $('.time-graph');
    stateGraphs = $('.state-graphs');

    setInterval(pullData, (1000 * 60 * 60 * 4));
    pullData();
  }

  function render(data){
    renderBar(data);
    renderStateGraphs(data);
  }

  function renderBar(data){
    var barGraph = generateBarGraph(data.charts.trends[0]);

    timeGraph.html('');
    timeGraph.append(barGraph);
  }

  function renderStateGraphs(data){
    var states =  data.charts.gauges.map(function(gauge){
      return generateStateGraph(gauge);
    });

    stateGraphs.html('');
    stateGraphs.append(states.join(''));
  }

  function generateStateGraph(graphData){
    var stateGraph = $(stateTemplate.html()),
        trend = stateGraph.find('.state-graph__trend');

    stateGraph.find('.state-graph__name').text(graphData.name);
    stateGraph.find('.state-graph__value').text(graphData.value);
    trend.text(graphData.diff + "%");
    if(graphData.positive){
      trend.addClass('state-graph__trend--up');
    }
    else {
      trend.addClass('state-graph__trend--down');
    }

    return stateGraph[0].outerHTML;
  }

  function generateBarGraph(graphData){
    var barGraph = $(barTemplate.html()),
        labels,
        bars;

    bars = graphData.data.map(function(bar){
      return getBarElement(bar);
    });

    labels = barGraph.html();

    barGraph.html('');
    barGraph.append(labels);
    barGraph.append(bars.join(''));
    barGraph.find('.bar-graph__y-label').text(graphData.label.y);
    barGraph.find('.bar-graph__x-label').text(graphData.label.x);

    return barGraph[0].outerHTML;
  }

  function getBarElement(bar){
    var barElement = $('<div />');

    barElement.addClass('bar-graph__bar');
    barElement.css({
      height: bar + '%',
      background: 'rgb(240,' + bar + ', 0)'
    });
    barElement.text(bar + '%');

    return barElement[0].outerHTML;
  }

  function pullData(){
    $.ajax ({
      url : '/api/metrics/qwerty123456',
      method: 'GET',
      success: function(result){
        render(result);
      }
    })
  }

  $(init);
}(jQuery));