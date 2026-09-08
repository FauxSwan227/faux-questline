const fallbackPayload = {
  brand: {
    logoText: 'F',
    logoImage: 'img/logo.png',
    product: 'Onboard',
    version: 'City Guide',
  },
  pages: [
    {
      id: 'arrival',
      eyebrow: 'First Steps',
      title: 'Welcome to the City',
      subtitle: 'Start here after creating your character.',
      body: 'This guide gives you the essentials before you step out and begin your story.',
      locationLabel: 'Airport Arrival',
      mapLabel: 'Los Santos International',
      locationImage: 'img/contract-bg.avif',
      mapImage: 'img/map-placeholder.svg',
      final: false,
    },
    {
      id: 'cityhall',
      eyebrow: 'Identity',
      title: 'Visit City Hall',
      subtitle: 'Collect documents, licenses, and civic services.',
      body: 'City Hall is where new residents handle official paperwork. Use it to understand identification, licensing, legal registration, and other important civilian systems.',
      locationLabel: 'City Hall',
      mapLabel: 'Downtown Marker',
      locationImage: 'img/contract-bg.avif',
      mapImage: 'img/map-placeholder.svg',
      final: false,
    },
    {
      id: 'apartments',
      eyebrow: 'Housing',
      title: 'Find Your First Home',
      subtitle: 'Apartments give your character a place to settle.',
      body: 'Starter apartments or housing systems help you store items, change outfits, and establish a personal base. If starter apartments are disabled, follow staff guidance for your first housing option.',
      locationLabel: 'Apartment Desk',
      mapLabel: 'Housing Area',
      locationImage: 'img/contract-bg.avif',
      mapImage: 'img/map-placeholder.svg',
      final: false,
    },
    {
      id: 'jobs',
      eyebrow: 'Work',
      title: 'Choose Early Jobs',
      subtitle: 'Legal jobs are the easiest way to learn the economy.',
      body: 'Starter work introduces routes, payouts, city locations, and useful roleplay loops. Try simple jobs first before moving into deeper careers, whitelisted roles, or risky opportunities.',
      locationLabel: 'Job Center',
      mapLabel: 'Employment Marker',
      locationImage: 'img/contract-bg.avif',
      mapImage: 'img/map-placeholder.svg',
      final: false,
    },
    {
      id: 'services',
      eyebrow: 'Essentials',
      title: 'Use City Services',
      subtitle: 'Phone, banking, shops, garages, and support systems.',
      body: 'Your phone, bank account, vehicle access, shops, and public service contacts will carry most day-to-day interactions. Learn these early and the rest of the city becomes much easier to navigate.',
      locationLabel: 'Service District',
      mapLabel: 'Central Services',
      locationImage: 'img/contract-bg.avif',
      mapImage: 'img/map-placeholder.svg',
      final: false,
    },
    {
      id: 'journey',
      eyebrow: 'Begin',
      title: 'Start Your Journey',
      subtitle: 'You now have the foundation.',
      body: 'Explore at your own pace, ask questions in character, and let your story build naturally.',
      locationLabel: 'Open City',
      mapLabel: 'Your Next Destination',
      locationImage: 'img/contract-bg.avif',
      mapImage: 'img/map-placeholder.svg',
      final: true,
    },
  ],
  keybindPages: [
    {
      title: 'Movement',
      items: [
        { keys: ['W', 'A', 'S', 'D'], title: 'Move', description: 'Walk, strafe, and back up your character.' },
        { keys: ['Shift'], title: 'Sprint', description: 'Hold while moving to run.' },
        { keys: ['Space'], title: 'Jump', description: 'Hop over low obstacles.' },
        { keys: ['Ctrl'], title: 'Crouch', description: 'Toggle a lower stance where supported.' },
        { keys: ['F'], title: 'Enter Vehicle', description: 'Get in or out of nearby vehicles.' },
        { keys: ['B'], title: 'Point', description: 'Use a quick pointing animation.' },
      ],
    },
    {
      title: 'Interaction',
      items: [
        { keys: ['Alt'], title: 'Target Eye', description: 'Look at nearby objects, people, and doors for interactions.' },
        { keys: ['E'], title: 'Interact', description: 'Use prompts, doors, pickups, and service points.' },
        { keys: ['I'], title: 'Inventory', description: 'Open your carried items.' },
        { keys: ['M'], title: 'Phone', description: 'Open phone apps and contacts.' },
        { keys: ['K'], title: 'Menu', description: 'Open the personal action menu.' },
        { keys: ['T'], title: 'Chat', description: 'Focus the chat input.' },
      ],
    },
  ],
  commandPages: [
    {
      title: 'Quick Commands',
      items: [
        { command: '/help', description: 'Open the help menu.', requiresParameters: false },
        { command: '/hud', description: 'Toggle or adjust HUD settings.', requiresParameters: false },
        { command: '/id', description: 'Show your server ID.', requiresParameters: false },
        { command: '/report', description: 'Contact staff. Requires a message after the command.', requiresParameters: true },
        { command: '/me', description: 'Describe an in-character action. Requires text.', requiresParameters: true },
        { command: '/do', description: 'Describe scene details. Requires text.', requiresParameters: true },
      ],
    },
    {
      title: 'Roleplay Basics',
      items: [
        { command: '/ooc', description: 'Send an out-of-character message. Requires text.', requiresParameters: true },
        { command: '/cash', description: 'Check carried cash where supported.', requiresParameters: false },
        { command: '/bank', description: 'Check bank balance where supported.', requiresParameters: false },
        { command: '/emotes', description: 'Open the emote menu.', requiresParameters: false },
        { command: '/e', description: 'Play an emote. Requires an emote name.', requiresParameters: true },
        { command: '/clear', description: 'Clear your chat window.', requiresParameters: false },
      ],
    },
  ],
  faqs: [
    {
      question: 'Where should I go first?',
      answer: 'Start with City Hall, then learn your phone, inventory, banking, and garage options before chasing bigger goals.',
    },
    {
      question: 'How do I get help from staff?',
      answer: 'Use the configured report command with a clear message, or follow your community Discord support flow.',
    },
    {
      question: 'What should I do if a command needs parameters?',
      answer: 'Open chat, type the command, add the needed text or value, then submit it manually.',
    },
    {
      question: 'Why are some commands clickable and others not?',
      answer: 'Only commands that can safely run without extra text are clickable from this guide.',
    },
    {
      question: 'Can server owners edit this content?',
      answer: 'Yes. The tabs are fed from config, so keybinds, commands, and FAQs can be adjusted for your city.',
    },
  ],
  chapters: [
    {
      id: 'chapter-0',
      label: 'RadiantCoast Chapter 0',
      phase: 'Beta Phase',
      title: 'The Beta Begins',
      description: 'The first chapter of RadiantCoast is where the city opens its doors, its stories begin, and the community helps shape what comes next.',
      coverImage: 'img/contract-bg.avif',
      additions: ['RadiantCoast Beta is now live.'],
      changes: ['This chapter establishes the foundation for future city updates.'],
      fixes: ['Beta fixes and balance improvements will be documented here as they ship.'],
    },
  ],
};

let state = {
  payload: fallbackPayload,
  index: 0,
  chapterIndex: 0,
  activeTab: 'guide',
  infoIndexes: {
    keybinds: 0,
    commands: 0,
  },
};

const app = document.querySelector('#app');
const logoNodes = document.querySelectorAll('[data-logo]');
const dots = document.querySelector('[data-dots]');
const prevButton = document.querySelector('[data-prev]');
const nextButton = document.querySelector('[data-next]');
const completeButton = document.querySelector('[data-complete]');
const tabButtons = document.querySelectorAll('[data-tab]');
const panels = document.querySelectorAll('[data-panel]');
const keybindList = document.querySelector('[data-keybind-list]');
const commandList = document.querySelector('[data-command-list]');
const faqList = document.querySelector('[data-faq-list]');
const keybindSwitcher = document.querySelector('[data-keybind-switcher]');
const commandSwitcher = document.querySelector('[data-command-switcher]');
const chapterPrevButton = document.querySelector('[data-chapter-prev]');
const chapterNextButton = document.querySelector('[data-chapter-next]');

function nui(name, data = {}) {
  if (typeof GetParentResourceName !== 'function') return;

  fetch(`https://${GetParentResourceName()}/${name}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json; charset=UTF-8' },
    body: JSON.stringify(data),
  }).catch(() => {});
}

function normalizePayload(payload = {}) {
  return {
    ...fallbackPayload,
    ...payload,
    brand: { ...fallbackPayload.brand, ...(payload.brand || {}) },
    pages: payload.pages && payload.pages.length ? payload.pages : fallbackPayload.pages,
    keybindPages: payload.keybindPages && payload.keybindPages.length ? payload.keybindPages : fallbackPayload.keybindPages,
    commandPages: payload.commandPages && payload.commandPages.length ? payload.commandPages : fallbackPayload.commandPages,
    faqs: payload.faqs && payload.faqs.length ? payload.faqs : fallbackPayload.faqs,
    chapters: payload.chapters && payload.chapters.length ? payload.chapters : fallbackPayload.chapters,
    initialTab: payload.initialTab === 'chapters' ? 'chapters' : 'guide',
  };
}

function escapeHtml(value = '') {
  return String(value)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;');
}

function setText(selector, value) {
  document.querySelectorAll(selector).forEach((node) => {
    node.textContent = value || '';
  });
}

function normalizeAssetPath(path = '') {
  return String(path)
    .replace(/\\/g, '/')
    .replace(/^\.?\//, '')
    .replace(/^html\//, '');
}

function setVisual(selector, image) {
  const node = document.querySelector(selector);
  if (!node) return;

  const src = normalizeAssetPath(image);
  node.onerror = () => console.error(`[faux-onboard] Failed to load image: ${src}`);
  node.src = src;
}

function renderBrand() {
  const { brand } = state.payload;

  logoNodes.forEach((node) => {
    if (brand.logoImage) {
      const src = normalizeAssetPath(brand.logoImage);
      node.innerHTML = `<img src="${src}" alt="" onerror="console.error('[faux-onboard] Failed to load logo: ${src}')" />`;
      node.classList.add('has-logo-image');
      return;
    }

    node.textContent = brand.logoText || 'F';
    node.classList.remove('has-logo-image');
  });

  setText('[data-product]', brand.product || 'Onboard');
  setText('[data-version]', brand.version || 'City Guide');
}

function renderDots() {
  dots.innerHTML = state.payload.pages.map((_, index) => {
    const active = index === state.index ? 'active' : '';
    return `<button class="${active}" type="button" data-dot="${index}" aria-label="Go to slide ${index + 1}"></button>`;
  }).join('');
}

function renderTabs() {
  tabButtons.forEach((button) => {
    button.classList.toggle('active', button.dataset.tab === state.activeTab);
  });

  panels.forEach((panel) => {
    panel.classList.toggle('hidden', panel.dataset.panel !== state.activeTab);
  });
}

function renderSwitcher(target, tab, total) {
  if (!target || total <= 0) return;

  const current = state.infoIndexes[tab] || 0;
  target.innerHTML = `
    <button class="switch-button" type="button" data-info-prev="${tab}" ${current === 0 ? 'disabled' : ''} aria-label="Previous page">&lt;</button>
    <span class="switch-count">${current + 1}/${total}</span>
    <button class="switch-button" type="button" data-info-next="${tab}" ${current >= total - 1 ? 'disabled' : ''} aria-label="Next page">&gt;</button>
  `;
}

function renderKeybinds() {
  const pages = state.payload.keybindPages;
  const page = pages[state.infoIndexes.keybinds] || pages[0];
  if (!keybindList || !page) return;

  keybindList.innerHTML = (page.items || []).map((item) => {
    const keys = (item.keys || []).map((key, index) => {
      const joiner = index > 0 ? '<span class="keycap joiner">+</span>' : '';
      return `${joiner}<span class="keycap">${escapeHtml(key)}</span>`;
    }).join('');

    return `
      <article class="keybind-item">
        <div class="keycap-row" aria-label="${escapeHtml((item.keys || []).join(' plus '))}">${keys}</div>
        <div class="keybind-copy">
          <strong>${escapeHtml(item.title)}</strong>
          <span>${escapeHtml(item.description)}</span>
        </div>
      </article>
    `;
  }).join('');

  renderSwitcher(keybindSwitcher, 'keybinds', pages.length);
}

function commandName(command = '') {
  return command.replace(/^\//, '').split(/\s+/)[0];
}

function renderCommands() {
  const pages = state.payload.commandPages;
  const page = pages[state.infoIndexes.commands] || pages[0];
  if (!commandList || !page) return;

  commandList.innerHTML = (page.items || []).map((item, index) => {
    const locked = item.requiresParameters ? 'disabled' : '';
    const actionText = item.requiresParameters ? 'Needs parameters' : 'Click to run';

    return `
      <article class="command-item">
        <div class="command-tile">${escapeHtml(item.command)}</div>
        <div class="command-copy">
          <div>
            <strong>${escapeHtml(item.description)}</strong>
          </div>
          <button class="command-run-button" type="button" data-command-index="${index}" ${locked}>${actionText}</button>
        </div>
      </article>
    `;
  }).join('');

  renderSwitcher(commandSwitcher, 'commands', pages.length);
}

function renderFaqs() {
  if (!faqList) return;

  faqList.innerHTML = state.payload.faqs.map((item) => `
    <article class="faq-item">
      <h2>${escapeHtml(item.question)}</h2>
      <p>${escapeHtml(item.answer)}</p>
    </article>
  `).join('');
}

function renderChapterList(selector, items) {
  const node = document.querySelector(selector);
  if (!node) return;

  node.innerHTML = (items || []).map((item) => `<li>${escapeHtml(item)}</li>`).join('');
}

function renderChapters() {
  const chapters = state.payload.chapters;
  const chapter = chapters[state.chapterIndex] || chapters[0];
  if (!chapter) return;

  setText('[data-chapter-label]', chapter.label);
  setText('[data-chapter-phase]', chapter.phase);
  setText('[data-chapter-title]', chapter.title);
  setText('[data-chapter-description]', chapter.description);
  setText('[data-chapter-count]', `${state.chapterIndex + 1} / ${chapters.length}`);
  setVisual('[data-chapter-cover]', chapter.coverImage);
  renderChapterList('[data-chapter-additions]', chapter.additions);
  renderChapterList('[data-chapter-changes]', chapter.changes);
  renderChapterList('[data-chapter-fixes]', chapter.fixes);

  chapterPrevButton.disabled = state.chapterIndex === 0;
  chapterNextButton.disabled = state.chapterIndex >= chapters.length - 1;
}

function renderSlide() {
  const pages = state.payload.pages;
  const page = pages[state.index];
  const isFinal = page.final || state.index === pages.length - 1;

  setText('[data-current]', state.index + 1);
  setText('[data-total]', pages.length);
  document.querySelector('[data-progress-fill]').style.width = `${((state.index + 1) / pages.length) * 100}%`;

  setText('[data-eyebrow]', page.eyebrow);
  setText('[data-title]', page.title);
  setText('[data-subtitle]', page.subtitle);
  setText('[data-body]', page.body);
  setText('[data-location-label]', page.locationLabel);
  setText('[data-map-label]', page.mapLabel);

  setVisual('[data-location-image]', page.locationImage);
  setVisual('[data-map-image]', page.mapImage);

  prevButton.disabled = state.index === 0;
  nextButton.classList.toggle('hidden', isFinal);
  completeButton.classList.toggle('hidden', !isFinal);

  renderDots();
}

function render(payload) {
  state.payload = normalizePayload(payload);
  state.index = 0;
  state.chapterIndex = 0;
  state.activeTab = state.payload.initialTab;
  state.infoIndexes.keybinds = 0;
  state.infoIndexes.commands = 0;
  renderBrand();
  renderSlide();
  renderKeybinds();
  renderCommands();
  renderFaqs();
  renderChapters();
  renderTabs();
}

function close() {
  app.classList.add('hidden');
  nui('close');
}

function next() {
  if (state.index < state.payload.pages.length - 1) {
    state.index += 1;
    renderSlide();
  }
}

function prev() {
  if (state.index > 0) {
    state.index -= 1;
    renderSlide();
  }
}

function nextChapter() {
  if (state.chapterIndex < state.payload.chapters.length - 1) {
    state.chapterIndex += 1;
    renderChapters();
  }
}

function prevChapter() {
  if (state.chapterIndex > 0) {
    state.chapterIndex -= 1;
    renderChapters();
  }
}

document.addEventListener('click', (event) => {
  const tab = event.target.closest('[data-tab]');
  if (tab) {
    state.activeTab = tab.dataset.tab;
    renderTabs();
    return;
  }

  if (event.target.closest('[data-close]')) {
    close();
    return;
  }

  if (event.target.closest('[data-next]')) {
    next();
    return;
  }

  if (event.target.closest('[data-prev]')) {
    prev();
    return;
  }

  if (event.target.closest('[data-chapter-prev]')) {
    prevChapter();
    return;
  }

  if (event.target.closest('[data-chapter-next]')) {
    nextChapter();
    return;
  }

  if (event.target.closest('[data-complete]')) {
    app.classList.add('hidden');
    nui('complete');
    return;
  }

  if (event.target.closest('[data-map-click]')) {
    const page = state.payload.pages[state.index];
    app.classList.add('hidden');
    nui('setWaypoint', { pageId: page.id });
    return;
  }

  const dot = event.target.closest('[data-dot]');
  if (dot) {
    state.index = Number(dot.dataset.dot);
    renderSlide();
    return;
  }

  const infoPrev = event.target.closest('[data-info-prev]');
  if (infoPrev) {
    const tabName = infoPrev.dataset.infoPrev;
    state.infoIndexes[tabName] = Math.max(0, state.infoIndexes[tabName] - 1);
    tabName === 'keybinds' ? renderKeybinds() : renderCommands();
    return;
  }

  const infoNext = event.target.closest('[data-info-next]');
  if (infoNext) {
    const tabName = infoNext.dataset.infoNext;
    const list = tabName === 'keybinds' ? state.payload.keybindPages : state.payload.commandPages;
    state.infoIndexes[tabName] = Math.min(list.length - 1, state.infoIndexes[tabName] + 1);
    tabName === 'keybinds' ? renderKeybinds() : renderCommands();
    return;
  }

  const commandButton = event.target.closest('[data-command-index]');
  if (commandButton) {
    const page = state.payload.commandPages[state.infoIndexes.commands];
    const item = page && page.items ? page.items[Number(commandButton.dataset.commandIndex)] : null;
    if (!item || item.requiresParameters) return;

    nui('runCommand', { command: commandName(item.command) });
  }
});

document.addEventListener('keyup', (event) => {
  if (event.key === 'Escape') close();
  if (event.key === 'ArrowRight') state.activeTab === 'chapters' ? nextChapter() : next();
  if (event.key === 'ArrowLeft') state.activeTab === 'chapters' ? prevChapter() : prev();
});

window.addEventListener('message', (event) => {
  const { action, payload } = event.data || {};

  if (action === 'open') {
    render(payload);
    app.classList.remove('hidden');
  }

  if (action === 'close') {
    app.classList.add('hidden');
  }
});

render(fallbackPayload);

if (location.hostname === 'localhost' || location.hostname === '127.0.0.1') {
  app.classList.remove('hidden');
}
