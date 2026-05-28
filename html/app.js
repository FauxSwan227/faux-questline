const fallbackPayload = {
  brand: { logoText: 'S', product: 'Quests', version: 'V2.0 Stable' },
  profile: { name: 'Avery Cross', avatarUrl: '' },
  totals: { completed: 7, total: 12 },
  categories: [
    { id: 'civilian', label: 'Civilian Quests', shortLabel: 'Civilian', icon: 'user' },
    { id: 'lea', label: 'LEA Quests', shortLabel: 'Law Enforcement', icon: 'shield' },
    { id: 'criminal', label: 'Criminal Quests', shortLabel: 'Criminal', icon: 'skull' },
  ],
  quests: {
    civilian: [
      { id: 'fresh_off_the_boat', order: 1, title: 'Fresh Off The Boat', description: 'Visit City Hall, obtain your legal identification documents, and register your first bank account.', reward: '$2,500 Cash', rewardType: 'cash', status: 'available' },
      { id: 'honest_worker', order: 2, title: 'The Honest Worker', description: 'Complete 5 delivery shifts for Post-OP to prove your work ethic to the local trade council.', reward: 'Panto Key', rewardType: 'vehicle', status: 'current' },
      { id: 'settling_in', order: 3, title: 'Settling In', description: 'Purchase your first clothing items from Binco to fit in with the local population.', reward: '50 XP', rewardType: 'xp', status: 'completed' },
      { id: 'new_perspective', order: 4, title: 'A New Perspective', description: 'Unlock the city by meeting helpful locals around the Golden Station.', reward: 'Mystery Crate', rewardType: 'crate', status: 'locked' },
      { id: 'first_account', order: 5, title: 'First Account', description: 'Visit a bank teller and learn where paychecks, fines, and transfers are handled.', reward: 'Bank Bonus', rewardType: 'cash', status: 'locked' },
      { id: 'street_smart', order: 6, title: 'Street Smart', description: 'Talk to three city service NPCs and learn which systems they connect to.', reward: 'City Map', rewardType: 'item', status: 'locked' },
    ],
    lea: [
      { id: 'public_service', order: 1, title: 'Public Service', description: 'Meet a recruiter, learn department basics, and collect your application packet.', reward: 'Application Access', rewardType: 'access', status: 'available' },
      { id: 'ride_along', order: 2, title: 'Ride Along', description: 'Complete a supervised patrol route and report back to the station mentor.', reward: 'Cadet Badge', rewardType: 'badge', status: 'locked' },
    ],
    criminal: [
      { id: 'whispers', order: 1, title: 'Whispers In The Alley', description: 'Find a street contact near the old motel and learn how reputation gates illegal work.', reward: 'Contact Number', rewardType: 'contact', status: 'available' },
      { id: 'dirty_errand', order: 2, title: 'Dirty Errand', description: 'Move a sealed package without attracting attention.', reward: '$1,200 Dirty Cash', rewardType: 'cash', status: 'locked' },
    ],
  },
};

let state = {
  payload: fallbackPayload,
  selectedCategory: 'civilian',
};

const app = document.querySelector('#app');
const welcome = document.querySelector('#welcome');
const hub = document.querySelector('#hub');
const questList = document.querySelector('[data-quest-list]');
const categoryTabs = document.querySelector('[data-category-tabs]');
const sideTabs = document.querySelector('[data-side-tabs]');
const avatar = document.querySelector('[data-avatar]');

const icons = {
  user: '<svg viewBox="0 0 24 24"><path d="M20 21a8 8 0 0 0-16 0"/><circle cx="12" cy="7" r="4"/></svg>',
  shield: '<svg viewBox="0 0 24 24"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10Z"/></svg>',
  skull: '<svg viewBox="0 0 24 24"><path d="M8 17v-1a4 4 0 0 1-2-3.5C6 8.9 8.7 6 12 6s6 2.9 6 6.5A4 4 0 0 1 16 16v1"/><path d="M9 22v-3h6v3"/><path d="M9.5 12h.01M14.5 12h.01"/></svg>',
  fallbackAvatar: '<svg viewBox="0 0 24 24"><circle cx="12" cy="8" r="4"/><path d="M4 22a8 8 0 0 1 16 0"/></svg>',
};

function nui(name, data = {}) {
  if (typeof GetParentResourceName !== 'function') return;

  fetch(`https://${GetParentResourceName()}/${name}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json; charset=UTF-8' },
    body: JSON.stringify(data),
  }).catch(() => {});
}

function setText(selector, value) {
  document.querySelectorAll(selector).forEach((node) => {
    node.textContent = value;
  });
}

function normalizePayload(payload = {}) {
  return {
    ...fallbackPayload,
    ...payload,
    brand: { ...fallbackPayload.brand, ...(payload.brand || {}) },
    profile: { ...fallbackPayload.profile, ...(payload.profile || {}) },
    totals: { ...fallbackPayload.totals, ...(payload.totals || {}) },
    categories: payload.categories || fallbackPayload.categories,
    quests: payload.quests || fallbackPayload.quests,
  };
}

function renderBrand(payload) {
  document.querySelectorAll('[data-logo]').forEach((node) => {
    node.textContent = payload.brand.logoText || 'S';
  });
  setText('[data-product]', payload.brand.product || 'Quests');
  setText('[data-version]', payload.brand.version || 'V2.0 Stable');
}

function renderProfile(payload) {
  setText('[data-player-name]', payload.profile.name || 'New Arrival');
  if (payload.profile.avatarUrl) {
    avatar.style.backgroundImage = `url("${payload.profile.avatarUrl}")`;
    avatar.innerHTML = '';
    avatar.classList.add('has-image');
    return;
  }

  avatar.style.backgroundImage = '';
  avatar.innerHTML = icons.fallbackAvatar;
  avatar.classList.remove('has-image');
}

function renderTotals(payload) {
  const completed = Number(payload.totals.completed || 0);
  const total = Number(payload.totals.total || 0);
  const percent = total > 0 ? Math.min(100, Math.round((completed / total) * 100)) : 0;
  setText('[data-completed]', completed);
  setText('[data-total]', total);
  document.querySelector('[data-progress-fill]').style.width = `${percent}%`;
}

function renderTabs() {
  const tabs = state.payload.categories.map((category) => {
    const active = category.id === state.selectedCategory ? 'active' : '';
    return `<button class="${active}" type="button" data-category="${category.id}">${category.label}</button>`;
  }).join('');

  const side = state.payload.categories.map((category) => {
    const active = category.id === state.selectedCategory ? 'active' : '';
    return `
      <button class="${active}" type="button" data-category="${category.id}">
        ${icons[category.icon] || icons.user}
        <span>${category.shortLabel || category.label}</span>
      </button>
    `;
  }).join('');

  categoryTabs.innerHTML = tabs;
  sideTabs.innerHTML = side;
}

function rewardIcon(type) {
  const text = {
    cash: '$',
    vehicle: '◆',
    xp: 'XP',
    crate: '□',
    access: 'ID',
    badge: '★',
    contact: '#',
    item: '◇',
  }[type] || '★';

  return `<span class="reward-symbol">${text}</span>`;
}

function questAction(quest) {
  if (quest.status === 'completed') return '<button class="muted-button" type="button" disabled>Completed</button>';
  if (quest.status === 'locked') return '<button class="muted-button" type="button" disabled>Locked</button>';
  if (quest.status === 'current') return '<button class="muted-button resuming" type="button" disabled><span></span> Resuming...</button>';
  return `<button class="primary-button compact" type="button" data-start-quest="${quest.id}">Start Quest</button>`;
}

function renderQuests() {
  const category = state.payload.categories.find((item) => item.id === state.selectedCategory) || state.payload.categories[0];
  const quests = state.payload.quests[state.selectedCategory] || [];
  document.querySelector('[data-category-title]').textContent = category.label;

  questList.innerHTML = quests.map((quest) => `
    <article class="quest-card ${quest.status}">
      <div class="quest-index">${quest.status === 'completed' ? '✓' : `#${quest.order}`}</div>
      <div class="quest-copy">
        <div class="quest-title-row">
          <h2>${quest.title}</h2>
          ${quest.status === 'current' ? '<span class="pill">Current</span>' : ''}
        </div>
        <p>${quest.description}</p>
      </div>
      <div class="reward-card">
        ${rewardIcon(quest.rewardType)}
        <div>
          <span>${quest.status === 'completed' ? 'Reward Claimed' : 'Reward'}</span>
          <strong>${quest.reward}</strong>
        </div>
      </div>
      ${quest.status === 'locked' ? '<div class="locked-overlay"><span>⌑</span><em>Locked</em></div>' : ''}
      <div class="quest-action">${questAction(quest)}</div>
    </article>
  `).join('');
}

function render(payload) {
  state.payload = normalizePayload(payload);
  state.selectedCategory = state.payload.categories[0]?.id || 'civilian';
  renderBrand(state.payload);
  renderProfile(state.payload);
  renderTotals(state.payload);
  renderTabs();
  renderQuests();
}

function showHub() {
  welcome.classList.remove('active');
  hub.classList.add('active');
}

function showWelcome() {
  hub.classList.remove('active');
  welcome.classList.add('active');
}

document.addEventListener('click', (event) => {
  const categoryButton = event.target.closest('[data-category]');
  if (categoryButton) {
    state.selectedCategory = categoryButton.dataset.category;
    renderTabs();
    renderQuests();
    return;
  }

  if (event.target.closest('[data-open-hub]')) {
    nui('getStarted');
    showHub();
    return;
  }

  if (event.target.closest('[data-tour]')) {
    showHub();
    return;
  }

  const startQuest = event.target.closest('[data-start-quest]');
  if (startQuest) {
    nui('startQuest', {
      category: state.selectedCategory,
      questId: startQuest.dataset.startQuest,
    });
  }
});

document.addEventListener('keyup', (event) => {
  if (event.key === 'Escape') {
    nui('close');
    app.classList.add('hidden');
  }
});

window.addEventListener('message', (event) => {
  const { action, payload } = event.data || {};

  if (action === 'open') {
    render(payload);
    app.classList.remove('hidden');
    showWelcome();
  }

  if (action === 'close') {
    app.classList.add('hidden');
  }

  if (action === 'questHud') {
    const hud = document.querySelector('[data-quest-hud]');
    if (!payload?.visible) {
      hud.classList.add('hidden');
      return;
    }
    document.querySelector('[data-hud-title]').textContent = payload.title;
    document.querySelector('[data-hud-objective]').textContent = payload.objective;
    document.querySelector('[data-hud-cancel]').textContent = payload.cancelText;
    hud.classList.remove('hidden');
  }
});

render(fallbackPayload);

if (location.protocol === 'file:' || location.hostname === 'localhost' || location.hostname === '127.0.0.1') {
  app.classList.remove('hidden');
}
