export function setCurrentUser(data) {
  localStorage.setItem("currentUser", JSON.stringify(data));
}
export function getCurrentUser() {
  return JSON.parse(localStorage.getItem("currentUser"));
}