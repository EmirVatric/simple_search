const http = require("packs/helpers/requests");
const helpers = require("packs/helpers/helpers");
const dom = require("packs/helpers/dom");

document.addEventListener("turbolinks:load", function () {
  const searchBox = document.getElementById("index-search-box");
  const welcomeScreen = document.getElementById("index-welcome");
  const articlesContainer = document.getElementById("index-articles-container");
  const token = document.getElementsByName("csrf-token")[0].content;
  let ip = 123123123;
  let activity = [Date.now()];

  const updateDom = (data) => {
    articlesContainer.innerHTML = "";

    welcomeScreen.classList.add("display-none");
    articlesContainer.classList.remove("display-none");

    searchBox.value.length === 0
      ? dom.displayWelcomeScreen(welcomeScreen, articlesContainer)
      : data.errors.length > 0
      ? dom.appendError(data, articlesContainer)
      : dom.appendResults(data, articlesContainer);
  };

  const getData = helpers.debounce(async () => {
    activity.push(searchBox.value);
    const result = await http.post(
      {
        search: searchBox.value.trim().replace(/[?.!]/g, "").toLowerCase(),
        activity: activity,
        user_id: ip,
      },
      token
    );
    console.log(activity);
    updateDom(result);
  }, 700);

  searchBox.addEventListener("input", function (event) {
    if (event.which != 8) {
      searchBox.value.trim().length > 0
        ? getData()
        : ((activity = [Date.now()]), updateDom());
    }
  });
});
