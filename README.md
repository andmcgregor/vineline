#InterviewEase
> Turn your vine videos into an interactive timeline.

Note: web version currently not working due to no worker dynos on server + redis store.

<http://www.vineline.io/>

##About

I built Vineline in the week before starting Dev Bootcamp in Chicago. It involved API usage (since vines are fetched from a users timeline), web scraping (getting video info for each vine), background jobs (given the previous two points) and heavy use of javascript (to display each vine in an interactive format).

Things to do:
- Overall refactor
- Use Vine API directly rather than Twitter's.
- Make background jobs faster
- Improve Javascript (this was before I learned jQuery)

##Screenshot

![Vineline](/vineline.png)
