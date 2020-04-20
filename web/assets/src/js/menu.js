export function initMenu(menu, menuButton) {
  if (!menu || !menuButton) {
    return
  }

  menuButton.addEventListener('click', function() {
    menu.classList.toggle('menu--is-open')
  })

  const menuItemsWithChildren = menu.getElementsByClassName('menu__list-item--has-children')
  if (menuItemsWithChildren) {
    Array.from(menuItemsWithChildren).forEach(item => {
      const buttonList = item.querySelectorAll('button')
      if (buttonList && buttonList.length) {
        Array.from(buttonList).forEach(button => {
          button.addEventListener('click', function() {
            item.classList.toggle('menu__list-item--is-open')
          })
        })
      }
    })
  }
}