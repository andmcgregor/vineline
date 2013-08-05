window.onload = function (){

  /* Size of vld */

  function vldSize() {
      var size = 0, key;
      for (key in vld) {
          if (vld.hasOwnProperty(key)) size++;
      }
      return size;
  }

  function daysInMonth(month,year) {
      return new Date(year, month, 0).getDate();
    }

    function updateHighlighting(month, year)
    {
      // remove all highlighting
      var allDays = document.getElementsByClassName("vine_exists");
      for (var ii = 0; ii < allDays.length; ii++) {
        allDays[ii].setAttribute("class", "");
      }

      // make all dates possible

      document.getElementById("29").setAttribute("style", "");
      document.getElementById("30").setAttribute("style", "");
      document.getElementById("31").setAttribute("style", "");

      // add new day highlighting
      var daysArray = dates[year][month];
      for (var iii = 0; iii < daysArray.length; iii++) {
        document.getElementById(daysArray[iii]).setAttribute("class", "vine_exists");
        document.getElementById(daysArray[iii]).innerHTML = '<a href="http://vineline.io/users/'+gon.username1+'?year='+vld[i][2][0]+'&month='+vld[i][2][1]+'&day='+daysArray[iii]+'">'+daysArray[iii]+'</a>';
      }

      // add new month highlighting
      var monthsArray = [];

      for (var month_key in dates[year]) {
        monthsArray.push(month_key);
      }

      for (var iiii = 0; iiii < monthsArray.length; iiii++) {
        document.getElementById('m'.concat(monthsArray[iiii])).setAttribute("class", "vine_exists");
        document.getElementById('m'.concat(monthsArray[iiii])).innerHTML = '<a href="http://vineline.io/users/'+gon.username1+'?year='+vld[i][2][0]+'&month='+monthsArray[iiii]+'">'+months[monthsArray[iiii] - 1]+'</a>';
      }

      // add new year highlighting
      var yearsArray = [];

      for (var year_key in dates) {
        yearsArray.push(year_key);
      }

      for (var iiiii = 0; iiiii < yearsArray.length; iiiii++) {
        document.getElementById(yearsArray[iiiii]).setAttribute("class", "vine_exists");
        document.getElementById(yearsArray[iiiii]).innerHTML = '<a href="http://vineline.io/users/'+gon.username1+'?year='+yearsArray[iiiii]+'">'+yearsArray[iiiii]+'</a>';
      }

      // remove impossible dates
      var dim = daysInMonth(vld[i][2][1],vld[i][2][0]);

      if (dim === 28)
      {
        document.getElementById("29").setAttribute("style", "visibility: hidden;");
        document.getElementById("30").setAttribute("style", "visibility: hidden;");
        document.getElementById("31").setAttribute("style", "visibility: hidden;");
      }
      else if (dim === 29)
      {
        document.getElementById("30").setAttribute("style", "visibility: hidden;");
        document.getElementById("31").setAttribute("style", "visibility: hidden;");

      }
      else if (dim === 30)
      {
        document.getElementById("31").setAttribute("style", "visibility: hidden;");
      }
    }



  if ($('div.profile_page').length)
  {
    var vld = gon.vineline;

    vineline = document.getElementById("vineline");

    months = ['J','F','M','A','M','J','J','A','S','O','N','D'];

    /* 
      THINGS TO ADD:
      - show description
    */

    window.setTimeout(function(){
      updateHighlighting(vld[i][2][1], vld[i][2][0]);
      document.getElementById(vld[i][2][2]).setAttribute("class", "selected");
      document.getElementById('m'.concat(vld[i][2][1])).setAttribute("class", "selected");
      document.getElementById(vld[i][2][0]).setAttribute("class", "selected");
      vineline.src = vld[0][0];
      vineline.load();
      vineline.play();
    },1);

    /* Exists Highlighting - called initially + whenever month changes */

    var dates = gon.dates;

    /* Vineline play/pause */

    var i = 0;

    vineline.addEventListener('click', function(){
      if (vineline.paused)
      {
        vineline.play();
      }
      else
      {
        vineline.pause();
      }
    });

    /* Homepage video play/pause */

    /* Video Playlist */

    vineline.addEventListener('playing', function(){

      firstMonth = vld[0][2][1];
      prevMonth = vld[i - 1][2][1];
      currentMonth = vld[i][2][1];

      if (currentMonth !== prevMonth)
      {
        updateHighlighting(vld[i][2][1], vld[i][2][0]);
      }

    }, false);

    var vld_size = vldSize();

    vineline.addEventListener('ended', function(){
      i++;
      if (vld[i])
      {
        vineline.src = vld[i][0];
        document.getElementById(vld[i - 1][2][2]).setAttribute("class", "vine_exists");
        document.getElementById('m'.concat(vld[i - 1][2][1])).setAttribute("class", "vine_exists");
        document.getElementById(vld[i - 1][2][0]).setAttribute("class", "vine_exists");

        document.getElementById(vld[i][2][2]).setAttribute("class", "selected");
        document.getElementById('m'.concat(vld[i][2][1])).setAttribute("class", "selected");
        document.getElementById(vld[i][2][0]).setAttribute("class", "selected");
      }
      else
      {
        i = 0;
        vineline.src = vld[i][0];
        document.getElementById(vld[vld_size - 1][2][2]).setAttribute("class", "vine_exists");
        document.getElementById('m'.concat(vld[vld_size - 1][2][1])).setAttribute("class", "vine_exists");
        document.getElementById(vld[vld_size - 1][2][0]).setAttribute("class", "vine_exists");

        document.getElementById(vld[0][2][2]).setAttribute("class", "selected");
        document.getElementById('m'.concat(vld[0][2][1])).setAttribute("class", "selected");
        document.getElementById(vld[0][2][0]).setAttribute("class", "selected");
      }
      vineline.load();
      vineline.play();
    }, false);
  }
  else
  {
    homePageVideo = document.getElementById("home_page_video");

    homePageVideo.addEventListener('click', function(){
    if (homePageVideo.paused)
    {
      homePageVideo.play();
    }
    else
    {
      homePageVideo.pause();
    }
  });
  }
};