export async function getRequest(url, callback = () => {}) {
  const request = await fetch(url, {
    method: 'GET',
    headers: { 'Content-Type': 'application/json' },
    credentials: 'same-origin'
  });
  const data = await request.json();

  callback(data);
}

export async function postRequest(url, method = 'POST', post_params = {}, callback = () => {}) {
  const methodName = method.toUpperCase();
  const csrfToken = document.querySelector('[name="csrf-token"]').content;

  const request = await fetch(url, {
    method: methodName,
    headers: { 'Content-Type': 'application/json', 'X-CSRF-Token': csrfToken },
    credentials: 'same-origin',
    body: JSON.stringify(post_params)
  });
  const data = await request.json();

  callback(data);
}
