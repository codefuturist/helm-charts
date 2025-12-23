/**
 * Enhanced search and filtering for Helm chart values documentation
 */

document.addEventListener('DOMContentLoaded', function() {
  // Initialize values search if on a search page
  initValuesSearch();
  
  // Initialize filter buttons
  initFilterButtons();
  
  // Add anchor links to table rows
  addTableAnchors();
  
  // Initialize keyboard shortcuts
  initKeyboardShortcuts();
});

/**
 * Initialize the values search functionality
 */
function initValuesSearch() {
  const searchInput = document.getElementById('values-search');
  if (!searchInput) return;
  
  const table = document.querySelector('.values-table');
  if (!table) return;
  
  const rows = table.querySelectorAll('tbody tr');
  const resultsCount = document.querySelector('.search-results-count');
  
  searchInput.addEventListener('input', function(e) {
    const query = e.target.value.toLowerCase().trim();
    let visibleCount = 0;
    
    rows.forEach(row => {
      const key = row.querySelector('td:first-child')?.textContent.toLowerCase() || '';
      const type = row.querySelector('td:nth-child(2)')?.textContent.toLowerCase() || '';
      const description = row.querySelector('td:last-child')?.textContent.toLowerCase() || '';
      const section = row.dataset.section?.toLowerCase() || '';
      
      const matches = key.includes(query) || 
                     type.includes(query) || 
                     description.includes(query) ||
                     section.includes(query);
      
      row.style.display = matches ? '' : 'none';
      if (matches) visibleCount++;
    });
    
    if (resultsCount) {
      resultsCount.textContent = `Showing ${visibleCount} of ${rows.length} values`;
    }
    
    // Update URL with search query for sharing
    if (query) {
      history.replaceState(null, '', `?q=${encodeURIComponent(query)}`);
    } else {
      history.replaceState(null, '', window.location.pathname);
    }
  });
  
  // Check for query parameter on load
  const urlParams = new URLSearchParams(window.location.search);
  const initialQuery = urlParams.get('q');
  if (initialQuery) {
    searchInput.value = initialQuery;
    searchInput.dispatchEvent(new Event('input'));
  }
}

/**
 * Initialize filter buttons for quick filtering
 */
function initFilterButtons() {
  const filterButtons = document.querySelectorAll('.filter-btn');
  if (!filterButtons.length) return;
  
  filterButtons.forEach(btn => {
    btn.addEventListener('click', function() {
      const section = this.dataset.section;
      const table = document.querySelector('.values-table');
      if (!table) return;
      
      const rows = table.querySelectorAll('tbody tr');
      const isActive = this.classList.contains('active');
      
      // Toggle active state
      filterButtons.forEach(b => b.classList.remove('active'));
      if (!isActive) {
        this.classList.add('active');
      }
      
      rows.forEach(row => {
        if (isActive || !section) {
          // Show all
          row.style.display = '';
        } else {
          // Filter by section
          const rowSection = row.dataset.section || '';
          row.style.display = rowSection.includes(section) ? '' : 'none';
        }
      });
      
      // Update results count
      const visibleRows = table.querySelectorAll('tbody tr:not([style*="display: none"])');
      const resultsCount = document.querySelector('.search-results-count');
      if (resultsCount) {
        resultsCount.textContent = `Showing ${visibleRows.length} of ${rows.length} values`;
      }
    });
  });
}

/**
 * Add anchor links to table rows for deep linking
 */
function addTableAnchors() {
  const tables = document.querySelectorAll('.values-table');
  
  tables.forEach(table => {
    const rows = table.querySelectorAll('tbody tr');
    
    rows.forEach(row => {
      const keyCell = row.querySelector('td:first-child');
      if (!keyCell) return;
      
      const key = keyCell.textContent.trim();
      const anchorId = `value-${key.replace(/\./g, '-').replace(/\[/g, '_').replace(/\]/g, '')}`;
      
      row.id = anchorId;
      row.classList.add('value-anchor');
      
      // Add copy link button
      const link = document.createElement('a');
      link.href = `#${anchorId}`;
      link.className = 'anchor-link';
      link.title = 'Copy link to this value';
      link.innerHTML = ' 🔗';
      link.style.opacity = '0';
      link.style.transition = 'opacity 0.2s';
      link.onclick = function(e) {
        e.preventDefault();
        navigator.clipboard.writeText(window.location.origin + window.location.pathname + '#' + anchorId);
        
        // Show feedback
        const originalText = link.innerHTML;
        link.innerHTML = ' ✓';
        setTimeout(() => { link.innerHTML = originalText; }, 1500);
      };
      
      keyCell.appendChild(link);
      
      row.addEventListener('mouseenter', () => { link.style.opacity = '1'; });
      row.addEventListener('mouseleave', () => { link.style.opacity = '0'; });
    });
  });
  
  // Scroll to anchor if present in URL
  if (window.location.hash) {
    const target = document.querySelector(window.location.hash);
    if (target) {
      setTimeout(() => {
        target.scrollIntoView({ behavior: 'smooth', block: 'center' });
      }, 100);
    }
  }
}

/**
 * Initialize keyboard shortcuts
 */
function initKeyboardShortcuts() {
  document.addEventListener('keydown', function(e) {
    // Ctrl/Cmd + K to focus search
    if ((e.ctrlKey || e.metaKey) && e.key === 'k') {
      e.preventDefault();
      const searchInput = document.getElementById('values-search');
      if (searchInput) {
        searchInput.focus();
        searchInput.select();
      }
    }
    
    // Escape to clear search
    if (e.key === 'Escape') {
      const searchInput = document.getElementById('values-search');
      if (searchInput && document.activeElement === searchInput) {
        searchInput.value = '';
        searchInput.dispatchEvent(new Event('input'));
        searchInput.blur();
      }
    }
  });
}

/**
 * Copy value key to clipboard
 */
function copyValueKey(key) {
  navigator.clipboard.writeText(key).then(() => {
    // Show toast notification
    const toast = document.createElement('div');
    toast.textContent = `Copied: ${key}`;
    toast.style.cssText = `
      position: fixed;
      bottom: 20px;
      left: 50%;
      transform: translateX(-50%);
      background: var(--md-primary-fg-color, #4051b5);
      color: white;
      padding: 12px 24px;
      border-radius: 8px;
      z-index: 9999;
      animation: fadeInUp 0.3s ease;
    `;
    document.body.appendChild(toast);
    setTimeout(() => toast.remove(), 2000);
  });
}

// Add fadeInUp animation
const style = document.createElement('style');
style.textContent = `
  @keyframes fadeInUp {
    from {
      opacity: 0;
      transform: translateX(-50%) translateY(20px);
    }
    to {
      opacity: 1;
      transform: translateX(-50%) translateY(0);
    }
  }
`;
document.head.appendChild(style);
